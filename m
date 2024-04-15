Return-Path: <linux-kernel+bounces-145688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1A28A5987
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 20:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C10111F23CB6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04968139563;
	Mon, 15 Apr 2024 18:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mPHtal9R"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4A813666E
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 18:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713204218; cv=none; b=TrC71IsebQ2mZjFSacb8Nuc1XiTbd/bfFGCHvNm9mlVISXUu1ucuGg6x1TGsp/MWnnP+7ryiCHM7xR88xc8CgNr0lk2VanDhpEWp/xziwazSKBCzOmVvqctp8uzjw1htVUtGuo2h0FWOU0B143in9YmwstTtsFfvQD7VW0ThD3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713204218; c=relaxed/simple;
	bh=BcJCX3fHeAVnvh1e1UFXd7YRxpAPcrKnknm/wTKHg8Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ppwZCAJMTo747ppuxIaQqYrvzUltHAhRI4eE2Nip68ofv9rJvGMc4JG9IjA2ZpUFkPoivyP6tb/JIx6ACYgKirsX4PH57HduxneJohIPfZbVsuJPC3Z9hJb6Uc9Bs33rqT0sWH/492vrhK4T2B8a/qiyIGUbwwea6n4lEeMblKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mPHtal9R; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6ed01c63657so3163110b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 11:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713204216; x=1713809016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L4sux801NSFwuuMhJbH9Cvh1/+fruiCubgx731NNdqY=;
        b=mPHtal9RNa/NSFLiejQWXf2EpGPAICt8ZprT6zTWJN/5lRMXGYsousZ3XXkdq8PAPN
         bvSzjZYVloasa3Y16ficFTJs7ILzHNVSCBUlM3MxaGBM4+KvJiZkP9mn2X+r1q+Qcv3I
         QrGc/xsVc+TsXndxSGaeWdf80th1sjSwsvZ6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713204216; x=1713809016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L4sux801NSFwuuMhJbH9Cvh1/+fruiCubgx731NNdqY=;
        b=skRqGDoMJT6R1kRGqsARYTeCupZ1/3VrcE9I8lPVb1YYMCX4semosRbECnBYMxMi2Y
         Gif+cl3o0nokD38Ca+i8xit/rvc/u8MKSmWwwuldYh+lpO29kL207MTHhHoFXHEWukGU
         u7bh/g/BH3VX1PwUHketRt/7yAPYpxeCHhQuHb7acPlKSdCyNeAJr4Lalpq1DSUbdfqw
         Z/4tIqSVKA/B/6vRSOdFS5K/258mjGyEF0sOA39YrRyEQKc/6KHjyAcE3l89d0qA76rm
         AWF3u25hTcLziKFNLekbGwaS4Mu9i3ypG2Jdlng7IS/ZdEPb4pSclPGt/GfaBTV7W5+c
         L4/w==
X-Gm-Message-State: AOJu0YyCSsZIUfCd7LqtMZBm5xFQHrV375FWHViiQiopIPwMSQTBxP1m
	1Z/I2wSj+/LDfXiymDx9gjUH093YkhqCfXpSxGp8niWKvF8+XWPzTGBIJMXdrg==
X-Google-Smtp-Source: AGHT+IFIWOUYwYEZlxNFBi0wlOTgNr/4Lo8wgfnaN7h0tXPTNOrYhumHaZQ1GyIfyPJrf/G0omoagQ==
X-Received: by 2002:a05:6a21:47cb:b0:1a9:3cda:dc3c with SMTP id as11-20020a056a2147cb00b001a93cdadc3cmr9909409pzc.61.1713204216367;
        Mon, 15 Apr 2024 11:03:36 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id fh39-20020a056a00392700b006e69a142458sm7452150pfb.213.2024.04.15.11.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 11:03:35 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: linux-kernel@vger.kernel.org,
	linux-toolchains@vger.kernel.org,
	Vignesh Balasubramanian <vigbalas@amd.com>
Cc: Kees Cook <keescook@chromium.org>,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	aneesh.kumar@kernel.org,
	naveen.n.rao@linux.ibm.com,
	ebiederm@xmission.com,
	x86@kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-mm@kvack.org,
	bpetkov@amd.com,
	jinisusan.george@amd.com,
	matz@suse.de,
	binutils@sourceware.org,
	jhb@FreeBSD.org,
	felix.willgerodt@intel.com
Subject: Re: [PATCH 0/1] Replace the macro "ARCH_HAVE_EXTRA_ELF_NOTES" with kconfig
Date: Mon, 15 Apr 2024 11:03:32 -0700
Message-Id: <171320421021.253137.15736984105365154364.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412062138.1132841-1-vigbalas@amd.com>
References: <20240412062138.1132841-1-vigbalas@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 12 Apr 2024 11:51:37 +0530, Vignesh Balasubramanian wrote:
> This patch replaces the macro "ARCH_HAVE_EXTRA_ELF_NOTES" with kconfig
> as discussed here
> https://lore.kernel.org/lkml/CA+55aFxDk9_cmo4SPYMgG_WQ+_g5e_v6O-HEtQ_nTs-q1zjykg@mail.gmail.com/
> It is a pre-requisite patch for the review
> https://lore.kernel.org/lkml/20240314112359.50713-1-vigbalas@amd.com/
> I have split this patch as suggested in the review comment
> https://lore.kernel.org/lkml/87o7bg31jd.fsf@mail.lhotse/
> 
> [...]

Applied to for-next/execve, thanks!

[1/1] Replace macro "ARCH_HAVE_EXTRA_ELF_NOTES" with kconfig
      https://git.kernel.org/kees/c/a9c3475dd67b

Take care,

-- 
Kees Cook


