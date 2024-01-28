Return-Path: <linux-kernel+bounces-41857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C1783F8B8
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 18:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C83381C21C95
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA94D4CB5C;
	Sun, 28 Jan 2024 17:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hKDrzLnp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D79B4C627;
	Sun, 28 Jan 2024 17:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706463970; cv=none; b=GBj29JCABwEYt7SoWv/SoXGJezko1zjVhI3xxhAbv/y7haKmCojr+qKRDh21XJuOJkIqs5XmXSpg3GrH9UsgHkFqyeUfWZXqG5XQQm6QnZ1ftAvCPlpSf0dE/LRIeBZSzPt6MlsqBMwLL7nfOXYrSGMztLNPj8ue/Aqx88vAw6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706463970; c=relaxed/simple;
	bh=BjQIRF8nVXDS2r1inckIhVIOx6wVZvQH+HvmFHGysNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iOuqacB1hVXDX5ayDiXgoYeNrsbY0+VRxS3f0PansDUKO9Wr4uLu85nuQ4x3JdHZKeIpSv/pSu5jDXSjJsJQqy4PR3aVYxR4gw4P+wzW/gspHgDlrFBG7FT8JG7iYL3ighWEkpuA28rG/VnDEK8oOIGYJD4uh972sRzjAB95C9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hKDrzLnp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 731F7C43390;
	Sun, 28 Jan 2024 17:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706463969;
	bh=BjQIRF8nVXDS2r1inckIhVIOx6wVZvQH+HvmFHGysNc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hKDrzLnpqecjM4GBFOATdsqVjuAbGDF1aSC2rWTXONK5h4LGkDHKYK1pJuH38/RSH
	 mocAtujqyV7aNwikvdlI/jHfcxxTQhBvcgIKgHLMwnw89MlaOh17blOaZQTI/qz3xB
	 kVTjy55zHnZPmNNvPf6vdx7+C6B5Zcp2TUcImRVRUn2ro2lvDfoAHY2Ek//r70K5hx
	 YiRz0s2MIhw3kvA7ogkxq0YVFhnd4WNBKgDTrd+nfDhVrUex7zyFSfpf+uEs848UJ3
	 xFjbRDYrxq9pMBqn7hQvstAbqo9f/+tDbioa3tw+EGUYmhgWnsO1KC+yfVVMGIj5L1
	 4l5AI5hYbtLgw==
From: Bjorn Andersson <andersson@kernel.org>
To: konrad.dybcio@linaro.org,
	Tao Zhang <quic_taozhan@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@quicinc.com
Subject: Re: [PATCH] qcom: smem: remove hwspinlock from item get routine
Date: Sun, 28 Jan 2024 11:45:52 -0600
Message-ID: <170646395043.64610.5018917783604688842.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240102022512.999635-1-quic_taozhan@quicinc.com>
References: <20240102022512.999635-1-quic_taozhan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 02 Jan 2024 07:55:12 +0530, Tao Zhang wrote:
> During an SSR(Sub-System Restart) process, the remoteproc driver will
> try to read the crash reason from SMEM. The qcom_smem_get() backing such
> operations does however take the hwspinlock (tcsr mutex), which might be
> held by the dying remoteproc.
> 
> The associated timeout on the hwspin_lock_timeout_irqsave() would take
> care of the system not hanging forever, but the get operation will fail,
> unnecessarily delaying the process for the 'HWSPINLOCK_TIMEOUT' duration
> (currently is '1s'), and finally resulting in failure to get crash
> information from SMEM.
> 
> [...]

Applied, thanks!

[1/1] qcom: smem: remove hwspinlock from item get routine
      commit: 27825593c972abac86b9a4453a8c8c9a2c1ec60f

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

