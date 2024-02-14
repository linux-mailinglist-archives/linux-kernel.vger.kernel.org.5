Return-Path: <linux-kernel+bounces-65188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 073A1854922
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACF661F2A4B7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE5B1C6BB;
	Wed, 14 Feb 2024 12:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d7Zu30X5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1136A1C2BD;
	Wed, 14 Feb 2024 12:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707913323; cv=none; b=hEOrqMihKoIZqOZ//CeK2WPTIOI+r0WfxFLrFhktAPXlhLeQtrDDqtOrVvrifY/r1vcuQvOZlIZGpqH2wiPcvzo331cUNduC9VxfsqBKt764a8r8bDEWqyinXz6i0zgeDGYE9EWWPUjNFxoNyDz8XYPS1hSj41bkkrTp0XESA3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707913323; c=relaxed/simple;
	bh=LwkFI7+p8oCAuVQnG1sefqZieJrN8VzUlf25gAJ1Yq8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Cf0GnB+E5/2XLXaFIRpo+FGQGs7bO07DCNidsmeFB7ryZ2b90+nt9qwIr5ZBCM29vGy8Ra9qqklT0Ui8JQpEzdBM3E/LzjaiqBtDTJnFeMwQm5hdXSTA355dUiiOTqH/tLjyE773sVVupP+H2SQiN+Z00Uux4DRFZGJ7AEuMirs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d7Zu30X5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DED9C43394;
	Wed, 14 Feb 2024 12:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707913322;
	bh=LwkFI7+p8oCAuVQnG1sefqZieJrN8VzUlf25gAJ1Yq8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=d7Zu30X57/BUn6tN++GQwykOX1zQ/ldlz1/4mpNR/fWZTQDtLONUoVNnzg6kHhmEi
	 oJS4KUlnDqog/S5cyA4FpylbBbMRgDSQY8oklsPzb6C1PbR5X3i2yI98pFWpxETpMi
	 S7tXQVKsiV/hM505F9bWzvUkW081aofqJouSEt2TawT4uQ+r+KLl3HFvDunSyb6ecw
	 /ivOXN/5nc7dPr71QkB4VRi9bDngqy2c3sCXHShEnsRG4rA7B76xmCnxDREiJ2g99i
	 sHL7aRuTwDt0Fudxc8f9uEXWAHoLnoMIFQM3Xp7merrX9XJeIjwREHLbUgBRmZ3laA
	 51SuZ1SCiDi0Q==
From: Kalle Valo <kvalo@kernel.org>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "Arnd Bergmann" <arnd@kernel.org>,  "Jeff Johnson"
 <quic_jjohnson@quicinc.com>,  "Karthikeyan Periyasamy"
 <quic_periyasa@quicinc.com>,  "Aloka Dixit" <quic_alokad@quicinc.com>,
  "Wen Gong" <quic_wgong@quicinc.com>,  "Muna Sinada"
 <quic_msinada@quicinc.com>,  "Aditya Kumar Singh"
 <quic_adisi@quicinc.com>,  ath12k@lists.infradead.org,
  linux-wireless@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: ath12k: sanitize ath12k_mac_allocate() return code
References: <20240213100912.459018-1-arnd@kernel.org>
	<170790025305.3179441.138152315558305278.kvalo@kernel.org>
	<08ac32ef-610d-479d-a3fd-a3c3b8c4c697@app.fastmail.com>
	<87plwze34l.fsf@kernel.org>
	<d9a7ad2f-c9a7-4886-8bbc-7a77771c0aec@app.fastmail.com>
Date: Wed, 14 Feb 2024 14:21:58 +0200
In-Reply-To: <d9a7ad2f-c9a7-4886-8bbc-7a77771c0aec@app.fastmail.com> (Arnd
	Bergmann's message of "Wed, 14 Feb 2024 11:51:02 +0100")
Message-ID: <87le7ndymx.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Arnd Bergmann" <arnd@arndb.de> writes:

> On Wed, Feb 14, 2024, at 11:44, Kalle Valo wrote:
>> "Arnd Bergmann" <arnd@arndb.de> writes:
>>> On Wed, Feb 14, 2024, at 09:44, Kalle Valo wrote:
>>>> Arnd Bergmann <arnd@kernel.org> wrote:
>>
>>> but I see it's not in linux-next yet as of today.
>>
>> Yeah, it's a problem that ath.git is not included linux-next builds. The
>> commits will be in linux-next only after ath-next is pulled to
>> wireless-next :/
>
> Not sure if that is intentional, but if you'd like to change
> that, you can just email Stephen Rothwell asking him to include
> ath-next into linux-next as well.

We haven't done that as Stephen prefers that there are no "next-next"
patches in linux-next during the merge window and we don't want to stop
the development for two weeks.

But this is not the first time we get duplicate fixes due to the first
fix not being in linux-next, so we should fix this. I guess we could do
a similar for-next branch trick like we have in wireless-next? I'll talk
with Jeff and we'll see what we can do.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

