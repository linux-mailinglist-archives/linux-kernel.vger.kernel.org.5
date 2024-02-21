Return-Path: <linux-kernel+bounces-75450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3740185E8D5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 633431C21A19
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 20:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D943F8663A;
	Wed, 21 Feb 2024 20:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MuEJuTRk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA58F83CB2;
	Wed, 21 Feb 2024 20:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708546327; cv=none; b=HEiWtio1ZWJFPDS+jl/djilot5SPrZseLh/yibo60+apjxgPsE6kK452UwzEZh3AOkMEUBfQpwG0LOpz3stPXkmloM69emHFcrgCze9Y7YxZN/AE9Za0uimPZFgQ+2GAtjA37lz0OE9/4Ztuogz9fxClcQp4VUEJiKMnCLbCeXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708546327; c=relaxed/simple;
	bh=KKWjsYrhxbzP+pEV3+kQm3VuOC8L+ibneC+FX980NRc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ngagm93nxqAK4bNBqShcroak6aJkuB4DHRfMi+TGBw3zPflmgo7sjy9C9ZoqBr6yQNMUas89W9KXapM8cE78QXQ0LRRBRC6JK3ZxejyD9DCm4D0kn2fME7Dr7ttEsTIqwszUPIH1lYKEtsvtnjHEEZDg6v4A7fp+EBBxJgH/Td0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MuEJuTRk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD0F2C433F1;
	Wed, 21 Feb 2024 20:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1708546326;
	bh=KKWjsYrhxbzP+pEV3+kQm3VuOC8L+ibneC+FX980NRc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MuEJuTRkJMRKFh3mqp6fOZFvfpTamLVq2EoDhR5mfha94P8FQDRrLDaKnE+k3kAQZ
	 D+GTp72il9gGReGfi9Ecu5EvwmjwjIQjWeb5Sl3WDVdyp0MgKQCiHumttOefNnW4dZ
	 V8FEBJZwbop8/DmgOiy+uG0GbLTy+1K4MhvY4Dg8=
Date: Wed, 21 Feb 2024 12:12:05 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, piliu@redhat.com, linux-sh@vger.kernel.org,
 x86@kernel.org, kexec@lists.infradead.org, linux-mips@vger.kernel.org,
 ebiederm@xmission.com, loongarch@lists.linux.dev, hbathini@linux.ibm.com,
 linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v2 01/14] kexec: split crashkernel reservation code out
 from crash_core.c
Message-Id: <20240221121205.00202fab8c1732bc433a845f@linux-foundation.org>
In-Reply-To: <e1bd53c6-ad9a-46d5-9f49-ecdd64d98f61@linux.ibm.com>
References: <20240119145241.769622-1-bhe@redhat.com>
	<20240119145241.769622-2-bhe@redhat.com>
	<e1bd53c6-ad9a-46d5-9f49-ecdd64d98f61@linux.ibm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Feb 2024 22:59:47 +0530 Sourabh Jain <sourabhjain@linux.ibm.com> wrote:

> >   config ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
> > -	def_bool CRASH_CORE
> > +	def_bool CRASH_RESEERVE
> 
> %s/CRASH_RESEERVE/CRASH_RESERVE? 

Yes, thanks, this has been addressed in a followon fixup patch
in the mm.git tree.

