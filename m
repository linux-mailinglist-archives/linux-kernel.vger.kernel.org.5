Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39FC37BF534
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 10:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442707AbjJJICE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 10 Oct 2023 04:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442664AbjJJIB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 04:01:58 -0400
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7366CAC
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 01:01:56 -0700 (PDT)
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay09.hostedemail.com (Postfix) with ESMTP id 4CC7980211;
        Tue, 10 Oct 2023 08:01:55 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf01.hostedemail.com (Postfix) with ESMTPA id 7BA066000F;
        Tue, 10 Oct 2023 08:01:52 +0000 (UTC)
Message-ID: <5375f92abe85a49012c6bafbb21b579154d09f34.camel@perches.com>
Subject: Re: [PATCH 6/7] fs/sysfs/group: make attribute_group pointers const
From:   Joe Perches <joe@perches.com>
To:     Max Kellermann <max.kellermann@ionos.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Date:   Tue, 10 Oct 2023 01:01:51 -0700
In-Reply-To: <CAKPOu+_xPGdKuSdwh9NdKT+RGw1=JbpkBB3+GK0qnC8KbTyY7Q@mail.gmail.com>
References: <20231009165741.746184-1-max.kellermann@ionos.com>
         <20231009165741.746184-6-max.kellermann@ionos.com>
         <264fa39d-aed6-4a54-a085-107997078f8d@roeck-us.net>
         <CAKPOu+8k2x1CucWSzoouts0AfMJk+srJXWWf3iWVOeY+fWkOpQ@mail.gmail.com>
         <f511170fe61d7e7214a3a062661cf4103980dad6.camel@perches.com>
         <CAKPOu+_xPGdKuSdwh9NdKT+RGw1=JbpkBB3+GK0qnC8KbTyY7Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: 7BA066000F
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Rspamd-Server: rspamout06
X-Stat-Signature: yrj7dy1dfgwn4ruy9skeiteyin15jba1
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/PEXH+a0lwyCopcXDGV3v6dFylJ6/55s0=
X-HE-Tag: 1696924912-973839
X-HE-Meta: U2FsdGVkX1+lw6077CmRMG2PfmHdsoWxEEvyDAF2z9gzSasso1txhxPbv/j1LkdlhYnzTmdPRbMYD2+LV9vQvLpcPLk95XeHtaE4YduNbWMkIq/7WnFmCg/N2CiG0Sg27R/7weZUYmwJmYKeapxAlzFVuc8JJCr3sI2uKQExIScLY4j4cgtJt2tAvcBJLsABT66Q60zzg8HBjno5RarythjP9kbW73jWfMuIvfpDbSaL6u80ENY56rTZ8lPc5/CkhbnORqgP/XnCj28DY7ATZ/tOf7b+ZSnLOlv5lVZoekZfIa75mbUllFIIKf4NV2UzMDiKn9rP9RvmgZ7EbTEM4MPZEx/2tRFrQlgNRYtF3couji1+oM6PU9OZAroXvuyK
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-10-10 at 09:38 +0200, Max Kellermann wrote:
> On Tue, Oct 10, 2023 at 8:48 AM Joe Perches <joe@perches.com> wrote:
> > My opinion is that const use in the kernel should almost
> > always have whitespace before and after it except when
> > preceded by a open parenthesis or a newline.
> 
> So it shall be "void * const foo" (16k occurrences in the kernel)
> instead of "void *const foo" (3k occurrences)?

I think so.

$ git grep -P -oh "\bconst\s*\*" | sort | uniq -c | sort -rn | head -3
   2538 const *
    349 const*
     20 const	*
$ git grep -P -oh "\*\s*const\b" | sort | uniq -c | sort -rn | head -3
  16677 * const
   2912 *const
      8 *   const

Documentation/process/coding-style.rst doesn't mention const.
Maybe it should.

