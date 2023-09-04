Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656EE791F84
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 00:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240856AbjIDWaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 18:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233722AbjIDWaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 18:30:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B019D;
        Mon,  4 Sep 2023 15:30:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81062B80FCD;
        Mon,  4 Sep 2023 22:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBFC4C433C8;
        Mon,  4 Sep 2023 22:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693866624;
        bh=4yC+fr9M6gL7Ie5aoZuEBSSXO6paZy7H9zg904FBupw=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=XI0MOhb1pLSO57S+QzOYUb5lP5qOacgRK1ParNBcVdwNwQKOefXNwQuVdr59DRxcN
         t3YnjF3RI1+TmhwPcQxvwNoTJJn96znE/Mwxprej4CJsZlMPTTviMVE/ecn3RHdU++
         1yj/Vowz8S+OYuRsJkvWVUFhWGtCe/pnhuJbEn48Fip4mnmOqRoD8+C03LJGuVK5OQ
         hrfw/8dTJBrkmddgQ1+9uHh3F8i+XzPBtxSmTTaQ+kt1J5s1UxUr16but5gJLV6Jyg
         DhByop6lVP3S/UCZlo/MHM+wo6CYKXmR5odgZTmWfTgqD+QIkwNJI7IB/HI7o/xHR7
         xHWvrIJnyo1vQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 05 Sep 2023 01:30:20 +0300
Message-Id: <CVAHLR1F623E.UTKKMHXN3GC2@suppilovahvero>
Cc:     "Mario Limonciello" <mario.limonciello@amd.com>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <len.brown@intel.com>, <charles.d.prestopine@intel.com>,
        <rafael.j.wysocki@intel.com>
Subject: Re: REGRESSION WITH BISECT: v6.5-rc6 TPM patch breaks S3 on some
 Intel systems
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Tyler Stachecki" <stachecki.tyler@gmail.com>,
        "Todd Brandt" <todd.e.brandt@linux.intel.com>
X-Mailer: aerc 0.14.0
References: <5a344d1ffa66fac828feb3d1c6abce010da94609.camel@linux.intel.com>
 <CUV6EA5WZ2O5.5G3IV9BQITOG@suppilovahvero>
 <bd4890a3-419c-463d-88fe-905946122c9f@amd.com>
 <CUVTY0NCB0N6.VPFM83M83ZUR@suppilovahvero>
 <92b93b79-14b9-46fe-9d4f-f44ab75fd229@amd.com>
 <CUVV2MQRCGET.2U22LFQPX1J3G@suppilovahvero>
 <64f62f2f-91ef-4707-b1bb-19ce5e81f719@amd.com>
 <CUVVDC2QGWV6.HGLDFFEGMGGU@suppilovahvero>
 <eec91766-10a9-4d50-8e82-376f52f54be8@amd.com>
 <9f3b82466e36aef3591d03176c04663c89625d4a.camel@linux.intel.com>
 <ZPKiKrfVswqhrryZ@luigi.stachecki.net>
In-Reply-To: <ZPKiKrfVswqhrryZ@luigi.stachecki.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat Sep 2, 2023 at 5:47 AM EEST, Tyler Stachecki wrote:
> On Fri, Aug 18, 2023 at 02:39:58PM -0700, Todd Brandt wrote:
> > > > > > > > > > > > > While testing S3 on 6.5.0-rc6 we've found that 5
> > > > > > > > > > > > > systems are seeing
> > > > > > > > > > > > > a
> > > > > > > > > > > > > crash and reboot situation when S3 suspend is
> > > > > > > > > > > > > initiated. To
> > > > > > > > > > > > > reproduce
> > > > > > > > > > > > > it, this call is all that's required "sudo
> > > > > > > > > > > > > sleepgraph -m mem
> > > > > > > > > > > > > -rtcwake
> > > > > > > > > > > > > 15".
> > > > > > > > > > > >=20
> >=20
> > I just ran 6.5.0-rc6 plus this patch on all 5 machines where the
> > problem was detected and they work now. It looks good.
> >=20
> > Tested-by: Todd Brandt <todd.e.brandt@linux.intel.com>
>
> I just wanted to report that at least on an SBC running a J4105, this
> prevented the kernel from booting *at all* ever since 6.1.46 was released=
.
>
> The fix which drops the ret assignment above allows the SBC to successful=
ly
> boot a kernel again -- just mentioning for severity given that:
>   1) It also impacts the 6.1 LTS kernel that distros are tracking
>   2) In some cases, the kernel no longer boots anymore at all
>
> SBC this is seen on is a Seeed Studio ODYSSEY - X86J4105 for the curious.
>
> Tested-by: Tyler J Stachecki <stachecki.tyler@gmail.com>

Hi I submitted PR today:

https://lore.kernel.org/linux-integrity/20230904202512.29825-1-jarkko@kerne=
l.org/T/#u

I hope this ends the story but please if does not.

Unfortunately I missed this tested-by b4 sending the PR (sorry
about that).

BR, Jarkko
