Return-Path: <linux-kernel+bounces-83896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0879B869FDE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F18728FB87
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A89851C28;
	Tue, 27 Feb 2024 19:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="oBcEYDtu"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD9E3D988
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 19:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709060800; cv=none; b=SCPCcHP2ROdpBXQYdGBGSUGzn9AFL4udrJufb/5pdw6WNAqdDPGvohnJ+WOVVkWDilOriRbCbSNq2aUwYLPDGqWRPR+oHlPT5YEhYE8uwZoIL+ruXdNraQqkVZwGlZo0Hn645hNhbwCh3CRkEt/pg1MzIoExPUZWqptt2I7rJ8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709060800; c=relaxed/simple;
	bh=NV0RUIdXMlo6Z2/AE6LFM7XFkZwaYAIqi+3rgxbOiZg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=UIsWA42yjSRMzZ7q0C0LDA169N3QGq/A+bimK/oaa4au8G8kB1uMwWshUEtynqUV6yQWDC161phFX9vlbR9xI5x1AjkFgFlEHmc/ZFg1/lTkfJg58RHFRTUppG68PSLNEvqXvq4WMXPi1fo8HqLJbwBfYS3vzNZgCDjpLYf7drM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=oBcEYDtu; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from smtpclient.apple (d66-183-91-182.bchsia.telus.net [66.183.91.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 047D520B74C0;
	Tue, 27 Feb 2024 11:06:39 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 047D520B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1709060799;
	bh=3R4L23y6mvT50s2KsDN/kmp17xP0HbiJGH/JfodJIno=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=oBcEYDtusAVrVMGV7XA7J7FM5zrKZ5tex7b9gNLT5hYRG+hsJ4Ps3gynAEeQ/eDOc
	 188Lo1H6WAu8y7IPLdACuwBRZhl6eaLX/R7Ji2YWNW6KZaU91YEBwJ2Y50hM5nZ1uJ
	 mltZ4MDQKi6GkmmQIROsBdBhTcoljsaestWHY8kI=
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [PATCH] workqueue: Introduce from_wq() helper for cleaner
 callback declarations
From: Allen Pais <apais@linux.microsoft.com>
In-Reply-To: <Zd4xhvh9Drl4qrCV@slm.duckdns.org>
Date: Tue, 27 Feb 2024 11:06:28 -0800
Cc: jiangshanlai@gmail.com,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FDCF9C39-1696-4FE1-9728-31FE879AC36F@linux.microsoft.com>
References: <20240227185628.5336-1-apais@linux.microsoft.com>
 <Zd4xhvh9Drl4qrCV@slm.duckdns.org>
To: Tejun Heo <tj@kernel.org>
X-Mailer: Apple Mail (2.3774.400.31)

>=20
>=20
> On Tue, Feb 27, 2024 at 06:56:28PM +0000, Allen Pais wrote:
>> To streamline the transition from tasklets to worqueues, a new helper
>> function, from_wq(), is introduced. This helper, inspired by existing
>> from_() patterns, utilizes container_of() and eliminates the =
redundancy
>> of declaring variable types, leading to more concise and readable =
code.
>>=20
>> The modified code snippet demonstrates the enhanced clarity achieved
>> with from_wq():
>>=20
>>  void callback(struct work_struct *w)
>>   {
>>     - struct some_data_structure *local =3D container_of(w,
>> 						       struct =
some_data_structure,
>> 						       work);
>>     + struct some_data_structure *local =3D from_wq(local, w, work);
>=20
> I'm not necessarily against it but it's a bit meh in terms of how much =
it
> saves. Also, can you please name it from_work()?

  I agree :). It does help a little in conversion. Sure, will send out a =
v2 right away.

Thanks.

>=20
> Thanks.
>=20
> --=20
> tejun


