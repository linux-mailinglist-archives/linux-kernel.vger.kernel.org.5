Return-Path: <linux-kernel+bounces-89961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB9986F82A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 02:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0952DB20BDE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 01:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88CE10F9;
	Mon,  4 Mar 2024 01:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BcgTMRwF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375F0399
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 01:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709515529; cv=none; b=okRa0AbvWjxMiKGdFzFqjsNhkxW9zhDq1W3auoZlenwY/tu2SoEnOUSeNpsuPsJ2JZMA6fuEMsRSYqYCnPKBOdPzdd1nFJ4Y0Du5afaCPZF0v9uHXOZHwLYV3hf4nr8GGpFMlOEcRHB/bF1TFrNpuSVplOQ+1Znhvcq6Y7JAiko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709515529; c=relaxed/simple;
	bh=pbEla8fsO5S9tFM5YQ5Jg2RZxp5KAhMIEyBCKb7QDe4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oHr/Fdtnph+qMUUhiB4bhlTLen2qB5ktxh97Z5iiwgU61VrWi3OgTK83e7YQixl1Di5JmotLIrfC3R7SeO+x6ydLArCAA29O9jlt9+1VgaVF79asXkSqD8ytZ76SVUq6v/9iDoY164pKwwqSW1ifJAYx0Z0ELArlHBsI+YT1oi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BcgTMRwF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08882C433C7;
	Mon,  4 Mar 2024 01:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709515528;
	bh=pbEla8fsO5S9tFM5YQ5Jg2RZxp5KAhMIEyBCKb7QDe4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BcgTMRwFyru1beE1rEGlZwJaFGcYHbNTONO6IkTTlZAClcIMhuLylkUcRgIbu7l5b
	 50JNRkZfAghoksI7SsizTo6a8UWwjjcOrGZS76DioS7PNC9LnaIgirwYkEvM+oy6sJ
	 ZALp3Wnvz0wXZxuxqPFXi0TFx1X35rPjYfLFVh1QW7IqcZcghrfvWBIdOanGQ23oin
	 o4nLGBOtUQQF1ITzEWUM5kuK/t32nzF3KEb5ONzFU5KlX25T0WJD/A3uY/R2upVi6i
	 +omJnCXHPPbExL3tEVvgCFOAxIzc4fxrNzY27Rzpd1j4pXanuS7AuHYA/+LCorUokG
	 pi6yx322q93Nw==
Message-ID: <70320312-de6e-48a1-8074-c4e16e65555e@kernel.org>
Date: Mon, 4 Mar 2024 09:25:22 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] f2fs: fix to check return value
 __allocate_new_segment
Content-Language: en-US
To: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 niuzhiguo84@gmail.com, ke.wang@unisoc.com, hongyu.jin@unisoc.com
References: <1709281555-11373-1-git-send-email-zhiguo.niu@unisoc.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <1709281555-11373-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/3/1 16:25, Zhiguo Niu wrote:
> __allocate_new_segment may return error when get_new_segment
> fails, so its caller should check its return value.
> 
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

