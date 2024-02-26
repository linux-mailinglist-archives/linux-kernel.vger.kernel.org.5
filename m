Return-Path: <linux-kernel+bounces-82059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB33867E78
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CF2C1C28293
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4231612DD9B;
	Mon, 26 Feb 2024 17:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E2fBDFx0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8298712B166;
	Mon, 26 Feb 2024 17:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708968526; cv=none; b=eky3dwQycYaieqN2OBTiNmKOZzzOOFtMJBBv6JMvvTDqs7UdUsiivs9/agzLPU7xizRnJrO5SHhzNUVt8hDaU4wFmDtwwG48R+5fn6MVxeAyPDsv2047NO/d2l1jr0Rz1429ZySuZfFliSK61lCX6k7Amf/OswfZm8/xVzPXBS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708968526; c=relaxed/simple;
	bh=qr8UAbrHBfF/FTQvruGhcxy521yYQVPtZG8O7nIIvxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZnBS32lI2hgv+3nYIyTu3on/dvc01k4O4+P5gk8QK6qHUR40GRVaR+FcBXPQ0ubSSRvfhSzlONCSfx6Ef4diA6bIrwVLiIlOFHkXIFH0BcaHtO0TfzJPJzgf8D577sAr0bKNmlJATqlkGCUndIxcVRXWM6W8AcFTanhQxDX0Z2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E2fBDFx0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F905C43390;
	Mon, 26 Feb 2024 17:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708968526;
	bh=qr8UAbrHBfF/FTQvruGhcxy521yYQVPtZG8O7nIIvxo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E2fBDFx0N1Qyd8hMgB3M/cH7CYvs08xDWGCChpmnS5F7VFMeqcXeDiau2OVx5YPXA
	 C+hx8g91jGqVi+4zYpuqJ1bC2NDLcokadOViOr9sQfJwnaP8qj7RyG2XHBDk0l0Y6n
	 wt3Kz5M2EzOKa4cXAEGWtK02UgZsv8uZ6VkE6FMzYSGfja5jtBezmOOauMVpap2kmF
	 qiTAUZtOMLy6X5+agampnWOftfCoIzAY/sI9s7aUzxzmhylf/d1kh86Za6h6XjIwha
	 UQErqz5ChxQe4Ux8pAZrlM03f5NbPp0tITGmzw7GuPXaQ3Go072R+Yq1T3lSuR0hwq
	 GUUZXLV5tLfCw==
Date: Mon, 26 Feb 2024 09:28:43 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: qirui <qirui.001@bytedance.com>
Cc: bp@alien8.de, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
	jpoimboe@redhat.com, peterz@infradead.org, mbenes@suse.cz,
	gregkh@linuxfoundation.org, stable@vger.kernel.org,
	alexandre.chartre@oracle.com, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Support intra-function call validation
Message-ID: <20240226172843.52zidtcasjw4wbmh@treble>
References: <20240226094925.95835-1-qirui.001@bytedance.com>
 <f516eb83-c393-af67-803f-4cf664865cf8@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f516eb83-c393-af67-803f-4cf664865cf8@bytedance.com>

On Mon, Feb 26, 2024 at 07:33:53PM +0800, qirui wrote:
> This issue only occurs in 5.4 LTS versions after LTS 5.4.250
> (inclusive), and this patchset is based on commit
> 6e1f54a4985b63bc1b55a09e5e75a974c5d6719b (Linux 5.4.269)

Does the bug also exist in mainline?  If not, why?

-- 
Josh

