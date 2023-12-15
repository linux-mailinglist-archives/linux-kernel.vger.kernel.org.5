Return-Path: <linux-kernel+bounces-680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D75C7814469
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 10:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 739BE1F23550
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 09:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EFB179B7;
	Fri, 15 Dec 2023 09:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ar+MEkcH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4F717986
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 09:27:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDAC5C433C8;
	Fri, 15 Dec 2023 09:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702632470;
	bh=hYPAQIWLk8khuqHUwuIA1MRsSUVYCv86odQdWoEDCdQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ar+MEkcHFnCt8QuVaWalo6GF4nkAsmr/DHYeBxF91ZpTgeXcVGBksxuMerTBnaFDH
	 ZRdk76FjXNnbx7AbOQozWTTgTbsj8wshiazXMDSX6yMaVVL6ExJFNI3d+YfyCacVfl
	 v/eXaDIDy+AuWmcaTcUilH77G/FNtLp5d3UXvEaVQnc2pTJOv3iM1K1E05abawHxZR
	 xAt4TdZiQHncAO1/PISkvu0/dVfCI6pSFIQllHDW10IU7kiUeCVMYoygENiamJ94P3
	 8EdSpVNeGX09ZHMbMl7Ra0JB7w/4SCWRp7uZvxInPYmQK2VY+vy0QlhvJeUDPSw+fr
	 FVCsIox21GUIQ==
X-Mailer: emacs 29.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Nicholas Miehlbradt <nicholas@linux.ibm.com>, glider@google.com,
	elver@google.com, dvyukov@google.com, akpm@linux-foundation.org,
	mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu
Cc: linux-mm@kvack.org, kasan-dev@googlegroups.com, iii@linux.ibm.com,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Nicholas Miehlbradt <nicholas@linux.ibm.com>
Subject: Re: [PATCH 10/13] powerpc: Define KMSAN metadata address ranges for
 vmalloc and ioremap
In-Reply-To: <20231214055539.9420-11-nicholas@linux.ibm.com>
References: <20231214055539.9420-1-nicholas@linux.ibm.com>
 <20231214055539.9420-11-nicholas@linux.ibm.com>
Date: Fri, 15 Dec 2023 14:57:42 +0530
Message-ID: <87ttoju86p.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Nicholas Miehlbradt <nicholas@linux.ibm.com> writes:

> Splits the vmalloc region into four. The first quarter is the new
> vmalloc region, the second is used to store shadow metadata and the
> third is used to store origin metadata. The fourth quarter is unused.
>

Do we support KMSAN for both hash and radix? If hash is not supported
can we then using radix.h for these changes?

> Do the same for the ioremap region.
>
> Module data is stored in the vmalloc region so alias the modules
> metadata addresses to the respective vmalloc metadata addresses. Define
> MODULES_VADDR and MODULES_END to the start and end of the vmalloc
> region.
>
> Since MODULES_VADDR was previously only defined on ppc32 targets checks
> for if this macro is defined need to be updated to include
> defined(CONFIG_PPC32).

-aneesh

