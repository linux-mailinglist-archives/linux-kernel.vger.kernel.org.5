Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E78837BA13F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238645AbjJEOq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239168AbjJEOlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:41:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D9C87238
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:17:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03517C32778;
        Thu,  5 Oct 2023 11:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696506483;
        bh=IkhOtidzH+64ogOKIAsCEwo9wFFhyaMvN89vzlkDkXw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lIzoqeBQdTnHdX3ExaidTTaxCQautKMKcHdEeftu9MGo/k5tbTTEHubJbIxTPNKkj
         rqgBazlMaYOYF/zi/q89wDFkjpr+LAcUGtPUvdscRvGpLvNR+xKfxIU0tIY4i5FRKP
         MdWLzk+4fsIh7UMskrR89fIpZ2R4ztblG/pRBL7g=
Date:   Thu, 5 Oct 2023 13:48:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xia Fukun <xiafukun@huawei.com>
Cc:     prajnoha@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7] kobject: Fix global-out-of-bounds in
 kobject_action_type()
Message-ID: <2023100512-groom-diameter-eda0@gregkh>
References: <20230518091614.137522-1-xiafukun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518091614.137522-1-xiafukun@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 05:16:14PM +0800, Xia Fukun wrote:
> The following c language code can trigger KASAN's global variable
> out-of-bounds access error in kobject_action_type():
> 
> int main() {
>     int fd;
>     char *filename = "/sys/block/ram12/uevent";
>     char str[86] = "offline";
>     int len = 86;
> 
>     fd = open(filename, O_WRONLY);
>     if (fd == -1) {
>         printf("open");
>         exit(1);
>     }
> 
>     if (write(fd, str, len) == -1) {
>         printf("write");
>         exit(1);
>     }
> 
>     close(fd);
>     return 0;
> }
> 
> Function kobject_action_type() receives the input parameters buf and count,
> where count is the length of the string buf.
> 
> In the use case we provided, count is 86, the count_first is 85.
> Buf points to a string with a length of 86, and its first seven characters
> are "offline". In the for loop, kobject_actions[action] is the string
> "offline" with the length of 7,an out-of-boundary access will appear:
> 
> kobject_actions[action][85].
> 
> Use sysfs_match_string() to replace the fragile and convoluted loop.
> This function is well-tested for parsing sysfs inputs. Moreover, this
> modification will not cause any functional changes.
> 
> Fixes: f36776fafbaa ("kobject: support passing in variables for synthetic uevents")
> Signed-off-by: Xia Fukun <xiafukun@huawei.com>
> ---
> v6 -> v7:
> -  Move macro UEVENT_KACT_STRSIZE to the .c file to 
> improve maintainability.
> 
> v5 -> v6:
> - Ensure that the following extensions remain effective:
> https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-uevent
> 
> v4 -> v5:
> - Fixed build errors and warnings, and retested the patch.
> 
> v3 -> v4:
> - Refactor the function to be more obviously correct and readable.
> ---
>  lib/kobject_uevent.c | 38 +++++++++++++++++++++++++-------------
>  1 file changed, 25 insertions(+), 13 deletions(-)
> 
> diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
> index 7c44b7ae4c5c..2171e1648dad 100644
> --- a/lib/kobject_uevent.c
> +++ b/lib/kobject_uevent.c
> @@ -47,6 +47,14 @@ static LIST_HEAD(uevent_sock_list);
>  /* This lock protects uevent_seqnum and uevent_sock_list */
>  static DEFINE_MUTEX(uevent_sock_mutex);
>  
> +/*
> + * The maximum length of the string contained in kobject_actions[].
> + * If there are any actions added or modified, please ensure that
> + * the string length does not exceed the macro, otherwise
> + * should modify the macro definition.
> + */
> +#define UEVENT_KACT_STRSIZE		16

But the biggest size here is not 16, it's 6.  So where did 16 come from?
Why not dynamically determine the biggest size at runtime?

thanks,

greg k-h
