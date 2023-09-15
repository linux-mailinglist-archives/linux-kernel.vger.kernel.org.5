Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54197A1E17
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 14:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234630AbjIOMG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 08:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234606AbjIOMG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 08:06:28 -0400
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DEFB3A86
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 05:03:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1694779416; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=H9SJ2/ylRin1fjSy+mrNOs5Hu65G+9KER1RnNpQu74qp58wxXQfoQo+I/Hwpq9AT++UPrvDOrCs7EoS1+HWEc/CAsscSpb7xo+DyL/Wl1zG17fSqRLrknzW6lzb8dzXMARM8zcJIKemGV4g3alwf6aaI0p998ES/n3NalPmAeBA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1694779416; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
        bh=iVexVT2zh8T1OsT3V0tLN6PhoO+tdF7BsYZMZ241m5w=; 
        b=jto7nWBR0Ab/QDlOXIYl5jpsCN9QkDBzE+hJoyLZZXByF+oJTbQOhlgkW9aLuSg+CLurX1g1beCzlMR8ObITVNm87MnuqDI2Zdrm3iNhdonb8yzIu+3XJzrxhlyExA3QNkor7iaMk75zQVXK0BrB3AUbbGwtqMOWyZ1whFatEug=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=marliere.net;
        spf=pass  smtp.mailfrom=ricardo@marliere.net;
        dmarc=pass header.from=<ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1694779416;
        s=zmail; d=marliere.net; i=ricardo@marliere.net;
        h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
        bh=iVexVT2zh8T1OsT3V0tLN6PhoO+tdF7BsYZMZ241m5w=;
        b=FSiH66A9re+AWHXuPfZRuaH4bIruyMq83AEjZe2B0zuJ2oBnWbMtubCAd+YxSdnq
        DlB8xsar8HdIrBlzjjM768J8urk3AG9dILY7BD0JkJnYfEkmAlpy/7vTnpx03xYWT9F
        /A1xD59YtM0dbLAxqgV/w02BRziLtQQG8Jj01fTg=
Received: from localhost (177.104.93.54 [177.104.93.54]) by mx.zohomail.com
        with SMTPS id 1694779413281802.1657557561805; Fri, 15 Sep 2023 05:03:33 -0700 (PDT)
Date:   Fri, 15 Sep 2023 09:03:39 -0300
From:   "Ricardo B. Marliere" <ricardo@marliere.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        syzbot+bbc59256015533127d80@syzkaller.appspotmail.com
Subject: Re: [PATCH] drivers: core: ensure device has a name
Message-ID: <a6heh7hn45avcmttxvlmu6cobzjnsz6rsvpr7vkvvoqmadoikk@girnrpbu32go>
References: <20230915011930.199009-1-ricardo@marliere.net>
 <2023091533-subdued-antler-d6ac@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023091533-subdued-antler-d6ac@gregkh>
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/09/15 08:51AM, Greg Kroah-Hartman wrote:
> On Thu, Sep 14, 2023 at 10:19:31PM -0300, Ricardo B. Marliere wrote:
> > device_add() relies on dev_name() and dev_set_name() to set the device
> > name. This patch adds the fallback case where both the call to
> > dev_name() and (dev->bus && dev->bus->dev_name) fails.
> > 
> > Reported-by: syzbot+bbc59256015533127d80@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=bbc59256015533127d80
> > Fixes: d21fdd07cea4 ("driver core: Return proper error code when dev_set_name() fails")
> > Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> > ---
> >  drivers/base/core.c | 2 ++
> >  1 file changed, 2 insertions(+)
> 
> Already submitted and in linux-next:
> 	https://lore.kernel.org/r/20230828145824.3895288-1-andriy.shevchenko@linux.intel.com

Ah, of course. I'll do a better job grepping the mail next time :)

Thanks for reviewing,
-	Ricardo
