Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493C9812293
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 00:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjLMXC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 18:02:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjLMXC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 18:02:56 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E95D99;
        Wed, 13 Dec 2023 15:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702508584; x=1734044584;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=cozZxSkGzieURXERb/Sy+rCeOm0TXgG9x/5Y7sy6lZE=;
  b=bZr20q86e/vhN4hjORXbSnglGLEtIi2CYT0P/OQTTwip50KWkJr1IHSN
   ZSSd+8qTpiKv+OJ93X7KmoinhmSeR0V4nMq63yYue9RWeflnS7oUsmk9E
   timfGgYLit/CRWbXKKtvr5HiQZB6t946QWGIu5zBaYr7vxYVDbGg+NJw+
   HiWjnDPjDHV+XBgiPhtguWURU0T6Q9Qeh/8odOreAgaXp89ZQOTQcoVNJ
   1ySsxDIun1srSoNxGxnMjOU5J0BZMrcq6+gJ5GGzeGwhf9r7qY9muFk9S
   23BqAAd3mkmSdxIcg6ZKuVP+WZNQd/qJCx3o2t7pA0kf37GqBz/+JMY3r
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="8434935"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="8434935"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 15:03:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="750297780"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="750297780"
Received: from wanghuan-mobl1.amr.corp.intel.com (HELO [10.212.178.119]) ([10.212.178.119])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 15:03:02 -0800
Message-ID: <3287f6c9d5fb68a8ef915c0e7af8f3a6a262cd89.camel@linux.intel.com>
Subject: Re: [PATCH] crypto: tcrypt - add script tcrypt_speed_compare.py
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Wang Jinchao <wangjinchao@xfusion.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        stone.xulei@xfusion.com
Date:   Wed, 13 Dec 2023 15:03:02 -0800
In-Reply-To: <ZXkecmQGYT81R17C@fedora>
References: <202312101758+0800-wangjinchao@xfusion.com>
         <118d0b232f7daffc56db814f90dba7bad266c5ab.camel@linux.intel.com>
         <ZXkecmQGYT81R17C@fedora>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-12-13 at 11:01 +0800, Wang Jinchao wrote:
> On Tue, Dec 12, 2023 at 01:56:56PM -0800, Tim Chen wrote:
> > On Sun, 2023-12-10 at 18:19 +0800, WangJinchao wrote:
> > > Create a script for comparing tcrypt speed test logs.
> > > The script will systematically analyze differences item
> > > by item and provide a summary (average).
> > > This tool is useful for evaluating the stability of
> > > cryptographic module algorithms and assisting with
> > > performance optimization.
> >=20
> > I have found that for such comparison, the stability is
> > dependent on whether we allow the frequency to
> > float or we pin the frequency.  So in the past when
> > I use tcrypt, sometimes I have
> > to pin the frequency of CPU for stable results.
> >=20
> > One suggestion I have is for for you to also dump the
> > frequency governor and P-state info so we know
> > for the runs being compared, whether they are running
> > with the same CPU frequency.
> >=20
> > Tim=20
> >=20
> Thank you for the feedback. This information is valuable for stability te=
sting
> and performance optimization.
>=20
> However, I am uncertain about how to dump P-state information, or I belie=
ve that
> the script is unable to do so. The reasons are as follows:
>=20
> 1. The primary purpose of this script is to compare tcrypt logs, and it i=
s
> executed after the completion of the tcrypt tests. Consequently, it canno=
t
> dump P-state information during tcrypt's runtime.
>=20
> 2. In virtualized environments, there is no available information in the
> `/sys/devices/system/cpu/cpufreq` directory pertaining to P-state details=
.
>=20
> Am I correct in my understanding?
> I am considering documenting your suggestion in the script's comments.
> What are your thoughts?
> >=20
I think that will be fine.=20

Thanks.

Tim

