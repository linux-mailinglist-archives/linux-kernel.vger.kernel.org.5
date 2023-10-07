Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F17F7BC740
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 13:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343885AbjJGLlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 07:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjJGLlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 07:41:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F385BB6;
        Sat,  7 Oct 2023 04:41:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12080C433C8;
        Sat,  7 Oct 2023 11:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696678901;
        bh=VgylUM7zk0Dl3tHTAheTcH5TcrIM7+TR+ZDe5P5GAlU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r2Fsx2BTHs9odemk42u48Jjp0cc+6rKHPKXDqjeJzkcyNG7lnijNgl6mW3Yaxi29a
         JAh8CijSWTszMjltPoCqGKSQOOfMjSgDUI8tYFmJRyQt6d8iRorol41JuQbrbCrrUN
         gdhwMv/zwCNpRTDnVogz2Sg9dAxYXulM6qkK7xmU=
Date:   Sat, 7 Oct 2023 13:41:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yuran Pereira <yuran.pereira@hotmail.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        luiz.dentz@gmail.com,
        syzbot+39ec16ff6cc18b1d066d@syzkaller.appspotmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] Bluetooth: hci_conn_failed: Fixes memory leak
Message-ID: <2023100727-passive-untidy-8df4@gregkh>
References: <AM9P192MB12672AA34A0480B522D23741E8C8A@AM9P192MB1267.EURP192.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM9P192MB12672AA34A0480B522D23741E8C8A@AM9P192MB1267.EURP192.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 07, 2023 at 05:09:01PM +0530, Yuran Pereira wrote:
> The hci_conn_failed() function currently calls hci_connect_cfm(), which
> indirectly leads to the allocation of an l2cap_conn struct in l2cap_conn_add().
> This operation results in a memory leak, as the l2cap_conn structure
> becomes unreferenced.
> 
> To address this issue and prevent the memory leak, this patch modifies
> hci_conn_failed() to replace the call to hci_connect_cfm() with a
> call to hci_disconn_cfm().
> 
> Reported-by: syzbot+39ec16ff6cc18b1d066d@syzkaller.appspotmail.com
> Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>
> ---
>  net/bluetooth/hci_conn.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

What commit id does this fix?

thanks,

greg k-h
