Return-Path: <linux-kernel+bounces-101071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 649B887A1E3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 04:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E34AC1F23788
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 03:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A07D10965;
	Wed, 13 Mar 2024 03:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eGA9w2dG"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78FA10A2E
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 03:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710299914; cv=none; b=RBwotAew9z0YN33j8oYnYFcBF4fph8xLN+G56274o9fNDyppVY3hVOta/j7AgXAlU3gfeBiKE1oq+QXkEmfWHYFRkZWJ/o1SbdM3tELLVw0W96o3NKPhgwwajPR8drp7uIAlKtmeeoSCZPdD6OfT6F2Wa1ZFLE3pDlnE3IGeHXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710299914; c=relaxed/simple;
	bh=DiuiKuasqVoMN5PUXSR4ob9TkaURBd7jOgolAmglw7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXiAOekQmApDEFUrRivwinU78Y2WRsCQub6JtNRiS25UL1tRlTBVX4Tp03qmxvyzLYBQGjKWn4KyckIZTh5ZMLHUBVlpLajrJOEwQpM/UfpW/ZdXDRbDTixVVBdIA4HTH9vD2ReI9DYiDpSKBEC4dvQM2nj+CSWdNuXEUKHDvXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eGA9w2dG; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e6adf257fdso1067760b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 20:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710299912; x=1710904712; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ErBpDoChwJS3Dz9w/fXRIf25+ofQNHhqhOBTpwuSEJ8=;
        b=eGA9w2dG6q1CQgb5Usjj+KJ7Bn7vKT0CT5NkdhpLTHrihdjZ04QxLhB6Lw4IXPVpFT
         MvxNWCpUtuLd3fGpQXbAcdpfdl0TT68oLyCBMtkHAQ1Uu14XZ045je9BUlPDWMSZt7Ci
         NQ6+OFbxxMUrqGfM9Bbwo7nhDvbeMdsY7eQC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710299912; x=1710904712;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ErBpDoChwJS3Dz9w/fXRIf25+ofQNHhqhOBTpwuSEJ8=;
        b=iJGlEsGO1KCT0FARRCfpZd68tJRRKu0IHSACACEUN1Dlm+YleWDKg9ECfobO/vULiB
         C48MiUG/inSuzqWWH8R6/jojbN5oMxRKUjlceTy3AivMAkJYd6v3QE9MCVCNebBh/Sgg
         jzKcxQHvnb9bOsIqyJsT6ahzam8seMprBpLtT84vatlX430iopAstnd0I3ZQS82wv/hN
         IzsjUF7bt7mfeXhuQrG3dfbt7e3pXNkYVldRbVm57YgXj5U4Svj+3YD/DellHSjE5+1j
         wWYV+bYZnqHQFAUcmxAjFMFsd59He85IU4vA0QgiCFx8TVPKcPgnNyMjpDDf3B8uJ+Zo
         v5eg==
X-Forwarded-Encrypted: i=1; AJvYcCWJEJcN3cdrMRARSSTrhrfCtb6hzzli2ACmpugfExT0at5SM+/MFZPiibm4lO1OC6eHeTUwPxhuiGXPEr5rF08ZjhaOh1GTPrYv81yY
X-Gm-Message-State: AOJu0YxUdCv9W80Pcgbov3ZRvSuTNjezleburO8eFhkjtNO8j/oB3xZ1
	/dYP1NTgqARzk8OQC3I/SazTpKhHuqpTRXHffik+D1LiuqN5HHe4sZW8joTTmQ==
X-Google-Smtp-Source: AGHT+IFroIThZzohrORMRyBf4q2SfGniRe6Qp1geTDUSL9THSEZPoi4A4hryzimt0s4DNs3AfM3qQw==
X-Received: by 2002:a05:6a00:181d:b0:6e5:d3b9:2d06 with SMTP id y29-20020a056a00181d00b006e5d3b92d06mr1621988pfa.21.1710299912048;
        Tue, 12 Mar 2024 20:18:32 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c1-20020aa78c01000000b006e697bd5285sm3892427pfd.203.2024.03.12.20.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 20:18:31 -0700 (PDT)
Date: Tue, 12 Mar 2024 20:18:31 -0700
From: Kees Cook <keescook@chromium.org>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, bp@alien8.de,
	broonie@kernel.org, dave.hansen@linux.intel.com, debug@rivosinc.com,
	hpa@zytor.com, kirill.shutemov@linux.intel.com, luto@kernel.org,
	mingo@redhat.com, peterz@infradead.org, tglx@linutronix.de,
	x86@kernel.org, christophe.leroy@csgroup.eu,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org
Subject: Re: [PATCH v3 08/12] treewide: Use initializer for struct
 vm_unmapped_area_info
Message-ID: <202403122018.DCCE1E000@keescook>
References: <20240312222843.2505560-1-rick.p.edgecombe@intel.com>
 <20240312222843.2505560-9-rick.p.edgecombe@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312222843.2505560-9-rick.p.edgecombe@intel.com>

On Tue, Mar 12, 2024 at 03:28:39PM -0700, Rick Edgecombe wrote:
> So to be reduce the chance of bugs via uninitialized fields, perform a
> tree wide change using the consensus for the best general way to do this
> change. Use C99 static initializing to zero the struct and remove and
> statements that simply set members to zero.
> 
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

Thanks! This looks to do exactly what it describes. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

