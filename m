Return-Path: <linux-kernel+bounces-136885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE41689D962
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64F361F20EDA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D52B12D755;
	Tue,  9 Apr 2024 12:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PpyRWuhz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iY5wIUNT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963481A5A2
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 12:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712666907; cv=none; b=F6xqgfEhgTJC02gzz+UhAP6o3VZ6rW1oG00ZG9nT74hj32IJgyK7wpbJvPEAMPO8U4bcOu6Y+HxrKItvgX+/SoKMhxIYTYGMIvpf9jtewfrpb80o6jLs7LfeX4MkZuxPWwU9ush7t16kiWF2BfkTQIVLbB3lMz30gYJ+uKY4dK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712666907; c=relaxed/simple;
	bh=y5TDkk/5IEpRJ8c/7ML2C1/JHQCiNrlrR/9ycixW3JI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t50SAZ78yTLaSJZe3TalrI8GP3gtB0CLT71UzJiDJ3nlZQrpMbDhLdhXZ5DDboAk0rNOP1PHll5P9ywCf7Rh0j3siXwuUoCezyMKZJgkeMAFl7tdUdavEjTf0gnHhY8W0B13PG8uSYc/sR3Sf0JLZFak9F4RsjVSVKYO99cTENs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PpyRWuhz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iY5wIUNT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712666905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y5TDkk/5IEpRJ8c/7ML2C1/JHQCiNrlrR/9ycixW3JI=;
	b=PpyRWuhzameNxbXKq+FLaUxwVVuyU0yWYcYgWWUWqTsPxK+EN0d8aOwlzGOxMnqyge5P4K
	t0FPxf3KMLlGUhwXlKRQxy2czHnGYr2S4R7geeGmgwkHV2sisYsoV3FkZremibTzhGUE7b
	JFNDlWuVDxq5/dtjOQUjuioOKHEpzqLDghdu8LiPFipb+NHLjiqAv2NUu/0kMrxg6/HmRF
	/DzJEoSRT8+PrZr0wUVWRVYvZ4mNCdY5afQngzOR+65295iHHDtQ5GblJXwhbCNQt9MDF8
	mFgnFd98oB/1S3j0Slu++vIMwbPuYLTpHmVaZrh+GKR+Nvz1UtAI4HKxKaJfmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712666905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y5TDkk/5IEpRJ8c/7ML2C1/JHQCiNrlrR/9ycixW3JI=;
	b=iY5wIUNTA1cT7e1jiXMK7oNYhbn3txYlb+XeJQcoQCUp991BVJrufZTKj1UYBoqleRhHb6
	wFSoKtASyHw85nBQ==
To: Tony Luck <tony.luck@intel.com>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH 03/74] x86/cpu/vfm: Update
 arch/x86/include/asm/intel-family.h
In-Reply-To: <20240328163746.243023-4-tony.luck@intel.com>
References: <20240328163746.243023-1-tony.luck@intel.com>
 <20240328163746.243023-4-tony.luck@intel.com>
Date: Tue, 09 Apr 2024 14:48:24 +0200
Message-ID: <87v84q66sn.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Mar 28 2024 at 09:37, Tony Luck wrote:

> New CPU #defines encode vendor and family as well as model.
>
> Update the example usage comment in arch/x86/kernel/cpu/match.c
>
> Signed-off-by: Tony Luck <tony.luck@intel.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

