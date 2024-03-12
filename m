Return-Path: <linux-kernel+bounces-100128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 698B087923D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 11:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24DBE28235A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D556679B76;
	Tue, 12 Mar 2024 10:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="fSkUOcUx"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECD135F18;
	Tue, 12 Mar 2024 10:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710239748; cv=none; b=uXOCZJgqX0fzD2xFMQ8ZH+brjlpz7FcA7RqmHEydBtLU/DNcUuG45/O825aGvsnau31GSUOc8qL4loYO9c1o+vjPT59vcTyVhSjwy+HsSj4HXjZF3DzF+paLb/6wxEZT8HU+CDJncadbCosVD2HtRzeshVxJ1mVSERlpPU+Ib3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710239748; c=relaxed/simple;
	bh=3Ren6oCQrE76vKh+CCJiqBhAuW8cn+/gbi++0hCSJYo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GLCKJDqDsF0WQhDqQIjD6hD1O3pj0saj91qvB0JN6ePJtVVgTlYjS/LTdr20KiZKuAkjtuClI5KGyyI1gHhU5oPDfLdnxxPnEVXV0rKwOjiPp6yhrVZd+k4kLeelW3wavxO4bg6julM3KpFhelc7t3IW0vyoXSUqkzlMiECCuYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=fSkUOcUx; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1710239743;
	bh=RZEfYiLTkNnDL11Vo6sbxwGAoRDVBPoFLJr3cr56jVk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=fSkUOcUxT9cjPVrU6sP8jJWYfWnjxzJLfKf1w6I4iWC+czN6ATNMjWO3u4Ol/6NIA
	 klGcwVNW/8svX8Sa0TDuNXmzpmRaIWCIIJiAZwux8+TQ3uC3zJKgS+4d8VliKauaaY
	 QdI3599p5DxoYz1/zN+FEVUnepZ4ntyegPliodd6Q0GAAbzech0kGB5Sx2JeG/YXdz
	 RK3wuxQVdXT+La7rI/Bh4+uNV4SHIuCZXcVn2QbzLvPia4W0BFpkoWtyvQOi29Hrqo
	 QNBAi86yP7jeyw45oqpE9N7aCxKKaxoPn9m8zJIHkxcpuba/Z1fMqcONSLaWpLv5kc
	 BYSV9xOI9uHDA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tv95q63Rvz4x0t;
	Tue, 12 Mar 2024 21:35:43 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Stefan Berger <stefanb@linux.ibm.com>, Jarkko Sakkinen
 <jarkko@kernel.org>, linux-integrity@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, rnsastry@linux.ibm.com, peterhuewe@gmx.de,
 viparash@in.ibm.com
Subject: Re: [PATCH 2/2] tpm: of: If available Use linux,sml-log to get the
 log and its size
In-Reply-To: <663a3834-056e-4dda-99dd-16ee8734100e@linux.ibm.com>
References: <20240306155511.974517-1-stefanb@linux.ibm.com>
 <20240306155511.974517-3-stefanb@linux.ibm.com>
 <CZNS7FO53BHK.6NO93P0C0VY5@kernel.org>
 <CZNS9K4BJPQ8.2MD4WZS8YMI3W@kernel.org>
 <663a3834-056e-4dda-99dd-16ee8734100e@linux.ibm.com>
Date: Tue, 12 Mar 2024 21:35:43 +1100
Message-ID: <877ci74u0w.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Stefan Berger <stefanb@linux.ibm.com> writes:
> On 3/7/24 15:00, Jarkko Sakkinen wrote:
>> On Thu Mar 7, 2024 at 9:57 PM EET, Jarkko Sakkinen wrote:
>>> in short summary: s/Use/use/
>>>
>>> On Wed Mar 6, 2024 at 5:55 PM EET, Stefan Berger wrote:
>>>> If linux,sml-log is available use it to get the TPM log rather than the
>>>> pointer found in linux,sml-base. This resolves an issue on PowerVM and KVM
>>>> on Power where after a kexec the memory pointed to by linux,sml-base may
>>>> have been corrupted. Also, linux,sml-log has replaced linux,sml-base and
>>>> linux,sml-size on these two platforms.
>>>>
>>>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>>>
>>> So shouldn't this have a fixed tag, or not?
>> 
>> In English: do we want this to be backported to stable kernel releases or not?
>
> Ideally, yes. v3 will have 3 patches and all 3 of them will have to be 
> backported *together* and not applied otherwise if any one of them 
> fails. Can this be 'guaranteed'?

You can use Depends-on: <previous commit SHA> to indicate the relationship.

cheers

