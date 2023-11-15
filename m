Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D22397EC749
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 16:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjKOPbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 10:31:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjKOPbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 10:31:01 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003DE1A1;
        Wed, 15 Nov 2023 07:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700062259; x=1731598259;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x0ww2NaDEpoBqF699F0PH7f66Q17NF2vZrmc+hjJMMk=;
  b=HLdrNUujWcyMUNPxabFFliD/tpY6gMiii/tAaJJQ+ETc2WPdB2GhVkBZ
   AB+OY84r2ZU2pMb3O0nhQ0FciUtCbwatU7kLG0PXLMBRoann0Ha2tIz63
   bHtqykr4uqLmqGh/HEm5GqQdROfA7P0ayKY6DuUnYI1SQ681CujIgpRrw
   +06iS60jRO0W3U92Z47eIAYrB2Il6hj+panyemqk5SjhMSIxASAKn3o9k
   0+cUvW+kJmEAY/MQEeX+QaxBBIhynDq7kqEcNwtX/oG/rQeHy9a0GbO1y
   /3u0xP8Icjw44x9UwevjuRf0L9vcSzrfjLV+qX5Csyb/nvJa+vYTVxGu8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="370241814"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="370241814"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 07:30:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="1096477268"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="1096477268"
Received: from mtkaczyk-mobl.ger.corp.intel.com (HELO localhost) ([10.249.135.68])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 07:30:56 -0800
Date:   Wed, 15 Nov 2023 16:30:51 +0100
From:   Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
To:     junxiao.bi@oracle.com, Song Liu <song@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH] kernfs: support kernfs notify in memory recliam context
Message-ID: <20231115162915.000064f8@linux.intel.com>
In-Reply-To: <443775e1-ed94-452e-8f06-eadb777bede4@oracle.com>
References: <20231114185947.42829-1-junxiao.bi@oracle.com>
 <ZVPFMzHAx9JVz2ak@slm.duckdns.org>
 <c71f1cb7-14d6-45e4-9df1-dc9bc82deda8@oracle.com>
 <ZVPXd-3TshjeScek@slm.duckdns.org>
 <443775e1-ed94-452e-8f06-eadb777bede4@oracle.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Nov 2023 15:53:47 -0800
junxiao.bi@oracle.com wrote:

> Understood, thanks. Sound like depending on Userspace on memory reclaim=20
> path is really bad idea and the only option for fixing it is to remove=20
> that dependency, but i am not sure that is possible without breaking the=
=20
> consistency of metadata.
>=20
> Thanks,
>=20
> Junxiao.

Indeed the project of external metadata management if fragile. You cares ab=
out
IMSM here (same as me) so ideally we should implement metadata management in
kernel- I think that IMSM deserved that after 10 years on the market. There=
 is
no better option, other options are just "workarounds" for the lack of meta=
data
management in kernel.

Song, any comments here?

=46rom the second hand, there is native raid which should just work, so maybe=
 you
can switch to the native raid?

Thanks,
Mariusz
