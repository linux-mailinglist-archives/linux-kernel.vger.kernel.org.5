Return-Path: <linux-kernel+bounces-128196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6155D895769
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 921B81C22AAD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5358F134400;
	Tue,  2 Apr 2024 14:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kBsZ77iU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABB413175D;
	Tue,  2 Apr 2024 14:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712069152; cv=none; b=e182k1nsMKY8DwOdXiVOQ+KFcutT97W4sgg1JDriH8Ba2ebOAN724NlDMu2103NVMk2aTVqHD/SSyCY3LR7nG1R3GEhj0a+O3DAqpi7H3LpUE6K/Up/KIHnmKbI509mPcoLlfuBF0y+95F24xAAyyi7lS8wgQpf4IV889KbpYPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712069152; c=relaxed/simple;
	bh=Oke7dPH1XW52s7l/sASmdAoJ79tX8X7qCVqa+hbu58s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qKZ2Sk2Kj8iCgmiCz0748IK66wzrGNnJFluCEhGb5WpME04R4xiDddGX495mtoRnc15IgODSinaSLmAkK74zHQ9vSZPP3Tm0iFOm8z+GpqWwQnRrrJFz5jf2YsN6yWvcWuFzDDrk6wyz00uWZ6NvBIJLZUikcmprfQALIkS6VV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kBsZ77iU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 568FCC433F1;
	Tue,  2 Apr 2024 14:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712069152;
	bh=Oke7dPH1XW52s7l/sASmdAoJ79tX8X7qCVqa+hbu58s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kBsZ77iUPx5k5HYeQ/ICMipaKKVdimcFnPUlDAkjyHpG74Vlkg9AAMQDuF30r1kft
	 /uI78tkn3P8FyEu7w1efXzPpk7Cip54AW0DfE9x3Hq0/yrccOFJgRykIWQngKicpDs
	 lE1l0JXCWfDkKjC3OxzWvtEY/msWDVF3EYirtfK4/53BxXSYZ3GBbfudlQyv+4s/gY
	 ADri7C2kaxNU3Rh/mQ8Gx0XTF3gOEorXQGtmNx6cWk4c3iPPPh28Aq4GoOTDgCdEZz
	 W7txwItTlgEK2yYoJtLTYq1ANNBmVd57/0UP9NFk4VHJ4aCCLy7vUMSyBvSFJAyn3y
	 s4+vOK/UM9gGQ==
From: bp@kernel.org
To: ashish.kalra@amd.com,
	Ashish Kalra <Ashish.Kalra@amd.com>
Cc: bp@alien8.de,
	linux-kernel@vger.kernel.org,
	linux-tip-commits@vger.kernel.org,
	michael.roth@amd.com,
	thomas.lendacky@amd.com,
	x86@kernel.org
Subject: Re: [PATCH] x86/sev: Apply RMP table fixups for kexec.
Date: Tue,  2 Apr 2024 16:45:47 +0200
Message-ID: <20240402144547.18869-1-bp@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240312184757.52699-1-Ashish.Kalra@amd.com>
References: <20240312184757.52699-1-Ashish.Kalra@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Borislav Petkov <bp@alien8.de>

On Tue, Mar 12, 2024 at 06:47:57PM +0000, Ashish Kalra wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
> 
> RMP table start and end physical range may not be aligned to 2MB in
> the e820 tables

This already sounds fishy. Why may the range not be aligned? This is
BIOS, right? And BIOS can be fixed to align them properly.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

