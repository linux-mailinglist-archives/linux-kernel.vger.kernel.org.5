Return-Path: <linux-kernel+bounces-40922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C5583E81D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 01:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 494B51F23EC4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 00:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28C239B;
	Sat, 27 Jan 2024 00:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jzSK9hU2"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A03199;
	Sat, 27 Jan 2024 00:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706314603; cv=none; b=DC47818iTAPz8hXUBwyQXI+TTNamHAT2reU89dRlfoV6zSn2PBGGVRynKx4lUS8hNOJFXhNoN9FeeFl2ZSZKkswZAfrjuzm2WGVgMVESs7a14ZNxCB+PdmwmXrqhXYcYFZ8H/c7mhgNc6duao8AAitBwxlV+8z0Gq6FnVA+ZtC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706314603; c=relaxed/simple;
	bh=JE0M51hDt71bGoBDBFo9edm7n0oVInGu8hcf0iaynGo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tTWW+m9atYJ3mFEoDiNGHsjeaalHhs5WbQMuK5PGMFEOauQQJg0VR7MVTOytne0qYUoWiZtuzhwJay/nXaiu5l/N7G9MiDfmfGqnF5r2VG4U7Co3NroxoX1qJufY90ii1IaFqLTNs7DNlkCyL1Ky6w4vqtuuu1b9LoLiWDGBtq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jzSK9hU2; arc=none smtp.client-ip=192.55.52.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706314600; x=1737850600;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=JE0M51hDt71bGoBDBFo9edm7n0oVInGu8hcf0iaynGo=;
  b=jzSK9hU2w5sGRtOKK6FKut4s3aeH5lh0GhwJEslf2EubwV20bOTOlgbh
   SXDh02TdOTkWN1s3dqHZrMkujFsZJtPuTGD7TIEZXnCs0PA1omrwJq0xD
   d1BHqjLA/rHFAqILNNtZmzvQRLPJHaW/Gi5UxtqjAOFZxJ80QIj4BtfoI
   dqXv0uEgSAWp2HvyBU6BNRXlpCTwftdmGR6UetQl7Ebwk/zseT1a4zcGS
   hPad0N6+NQnXOMc3xiInVzPesHaC/HdSaZslYvmxLFvptbZZmN+qCgKUN
   0EkO+AjpzD1nmOO4FyiyJ9hHGfmYieSnRV+kWi8UTsB1q9fcuyaC5tSxw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="401480661"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="401480661"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 16:16:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="906468534"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="906468534"
Received: from vcostago-desk1.jf.intel.com (HELO vcostago-desk1) ([10.54.70.67])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 16:16:37 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: brauner@kernel.org, hu1.chen@intel.com, miklos@szeredi.hu,
 malini.bhandaru@intel.com, tim.c.chen@intel.com, mikko.ylinen@intel.com,
 lizhen.you@intel.com, linux-unionfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC v2 2/4] cred: Add a light version of override/revert_creds()
In-Reply-To: <CAOQ4uxgZG487EMwDsxH-KkMeDExGPEFQP3zQVKk8BaKkWuZwDQ@mail.gmail.com>
References: <20240125235723.39507-1-vinicius.gomes@intel.com>
 <20240125235723.39507-3-vinicius.gomes@intel.com>
 <CAOQ4uxgZG487EMwDsxH-KkMeDExGPEFQP3zQVKk8BaKkWuZwDQ@mail.gmail.com>
Date: Fri, 26 Jan 2024 16:16:36 -0800
Message-ID: <87sf2j4om3.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Amir Goldstein <amir73il@gmail.com> writes:

> On Fri, Jan 26, 2024 at 1:57=E2=80=AFAM Vinicius Costa Gomes
> <vinicius.gomes@intel.com> wrote:
>>
>> Add a light version of override/revert_creds(), this should only be
>> used when the credentials in question will outlive the critical
>> section and the critical section doesn't change the ->usage of the
>> credentials.
>>
>> To make their usage less error prone, introduce cleanup guards asto be
>> used like this:
>>
>>      guard(cred)(credentials_to_override_and_restore);
>>
>> or this:
>>
>>      scoped_guard(cred, credentials_to_override_and_restore) {
>>              /* with credentials overridden */
>>      }
>>
>> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
>
> You may add:
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
>
> I would also add:
> Suggested-by: Christian Brauner <brauner@kernel.org>
>

Forgot about that one.=20


Cheers,
--=20
Vinicius

