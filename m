Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFFE75E112
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 11:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjGWJ43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 05:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjGWJ42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 05:56:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE9210EC
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 02:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690106140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oakpx82n4m6+moPT1LMqZIYYFz99Erw7biw+BLa7Rco=;
        b=D6dvmPt7hp8avbfwPERyHyeMl8XBD/I/ugXRURiuqBuaBCmXHj14KbAA89rEJnXv08zahN
        5Isa9RrX2cy/2EQBgNpgM6BVdaZb81Jlu+R58+wdaYQjJWWXeYX7OjlLN6Sxlg75ZdDrJh
        Iq5shzxEFsz7XILWrjUkDcXxI64sT8w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-014eBbIyM-OhtRUhYqMgMA-1; Sun, 23 Jul 2023 05:55:38 -0400
X-MC-Unique: 014eBbIyM-OhtRUhYqMgMA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fc020021efso20747765e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 02:55:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690106138; x=1690710938;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oakpx82n4m6+moPT1LMqZIYYFz99Erw7biw+BLa7Rco=;
        b=fsmuaNSOQrM4ZvSqXCYdRZ8E+PQz472uwWQv7JWFUsJqMBP+J5DKD9fRJf2GseSAB6
         EZ029baoPtJeiEWG/osmyxJ7kko60hQUULiYkw33YuHiAn8QAFHGhE+dcFHo+UgI7GNo
         69vOeuygCOj6zGlWDXaEGKvxP7GK9XvfOTx+6NaAdy22wcxjKJ4B4UYjylnN9RkLIYiG
         4uGWzwqLDCCRsTl/FIsuIYHzhvMcQ7idbrzw6JB9A27FyR8LjcbdxaD946FIJD8k2wwB
         KrBdigqaNQL4GmYKuxW9+66fTQvPLraMyeJN/P4eFzAZEZGdfwyA7acMHwfhV5pqbEDJ
         kIog==
X-Gm-Message-State: ABy/qLZNsCWPIL9QzQ2pd+iAW1Q07XdHG8lUeyQ0QmST0mzKrrCPHIaV
        EYHLNM4LqhWLPUBtdWnMPR6R9xAQjurCnzl/3cHaVagBEYl1z4v83GdWBttHNaA3pDL8sEX5Att
        b7/7hFKQAsAiFe9x7TKSf0BJZ
X-Received: by 2002:a5d:4523:0:b0:314:36c5:e4c0 with SMTP id j3-20020a5d4523000000b0031436c5e4c0mr5830965wra.11.1690106137923;
        Sun, 23 Jul 2023 02:55:37 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE3f1FwtvlIDG9rQVwdC8t8ngS8l2Td11UMjhie4u2ZO64W+MeoqKeuBe+O2LsvYRvXoT1ZaA==
X-Received: by 2002:a5d:4523:0:b0:314:36c5:e4c0 with SMTP id j3-20020a5d4523000000b0031436c5e4c0mr5830954wra.11.1690106137599;
        Sun, 23 Jul 2023 02:55:37 -0700 (PDT)
Received: from redhat.com ([2.55.164.187])
        by smtp.gmail.com with ESMTPSA id x3-20020adfdd83000000b00314398e4dd4sm9252151wrl.54.2023.07.23.02.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 02:55:36 -0700 (PDT)
Date:   Sun, 23 Jul 2023 05:55:33 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Lin Ma <linma@zju.edu.cn>
Cc:     jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] vdpa: Complement vdpa_nl_policy for nlattr length
 check
Message-ID: <20230723053613-mutt-send-email-mst@kernel.org>
References: <20230723080507.3716924-1-linma@zju.edu.cn>
 <20230723050656-mutt-send-email-mst@kernel.org>
 <729f5c17.e4079.18982192866.Coremail.linma@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <729f5c17.e4079.18982192866.Coremail.linma@zju.edu.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 23, 2023 at 05:33:54PM +0800, Lin Ma wrote:
> Hello Michael,
> 
> > >
> > > The vdpa_nl_policy structure is used to validate the nlattr when parsing
> > > the incoming nlmsg. It will ensure the attribute being described produces
> > > a valid nlattr pointer in info->attrs before entering into each handler
> > > in vdpa_nl_ops.
> > > 
> > > That is to say, the missing part in vdpa_nl_policy may lead to illegal
> > > nlattr after parsing, which could lead to OOB read just like CVE-2023-3773.
> > 
> > Hmm.
> > 
> > https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-3773
> > 
> > ** RESERVED ** This candidate has been reserved by an organization or individual that will use it when announcing a new security problem. When the candidate has been publicized, the details for this candidate will be provided.
> > 
> 
> Yeah, that CVE is assigned while fix not upstream yet. FYI, the fix is pending too. 
> See, https://marc.info/?l=linux-kernel&m=169009801131058&w=2.
> 
> > 
> > > This patch adds three missing nla_policy to avoid such bugs.
> > > 
> > > Fixes: 90fea5a800c3 ("vdpa: device feature provisioning")
> > > Fixes: 13b00b135665 ("vdpa: Add support for querying vendor statistics")
> > > Fixes: ad69dd0bf26b ("vdpa: Introduce query of device config layout")
> > > Signed-off-by: Lin Ma <linma@zju.edu.cn>
> > 
> > I don't know how OOB triggers but this duplication is problematic I
> > think: we are likely to forget again in the future.  Isn't there a way
> > to block everything that is not listed?
> > 
> 
> Sure, that is another undergoing task I'm working on. If the nlattr is parsed with
> NL_VALIDATE_UNSPEC, any forgotten nlattr will be rejected, therefore (which is the default
> for modern nla_parse). The problem here is that there are still consumers for
> nla_parse_deprecated. And we cannot simply replace all *_deprecated to modern ones
> as it may break userspace. See the commit message in 8cb081746c03 ("netlink: make
> validation more configurable for future strictness")
> 
> I believe if we can do enough test against userspace toolchains, we can ultimately
> upgrade all *_depprecated parsers to modern ones, which costs time and efforts. This
> send patch is a much simpler (but temporary) solution for now.
> 
> Regards
> Lin

Hmm but vdpa does not use nla_parse_deprecated does it? And in fact was
introduced after 8cb081746c031fb164089322e2336a0bf5b3070c.
So why is there an issue in vdpa?

-- 
MST

