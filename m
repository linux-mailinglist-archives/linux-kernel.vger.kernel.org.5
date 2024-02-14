Return-Path: <linux-kernel+bounces-65758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAEB855139
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE107292767
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB4A12F5AF;
	Wed, 14 Feb 2024 17:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bELou2lK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A352E12F58A;
	Wed, 14 Feb 2024 17:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707933491; cv=none; b=TQ5vPM+eTNIhHYyrLu5f5Op9XdoDLu6e7lfgJ0zXiomCCoYhlDvJXUAMiTnYLlJ9+tpM/DFNDXoVML0h/njXUpB9mVgWW00RZ0+qyTKpg4PW0wc7bkHgjAYTkT3oF9GrZQLlZDsgTlLmokXGoEgm2Vk5fI6R3IbDVTL2iyl8oGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707933491; c=relaxed/simple;
	bh=susKoy4B5RTliSEK+0G1W/v7LQ+gMOaRTK0A7H27Nhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sI5d7yZ1MTIjveEWHtsd+t3m8sMgEPNUjgSDcGLg233jvhKJ4noncFVxqR+7GesB23F2AVxpRkMftSwI0gtNMj/eXvmPed5Akmc9LWMSSgLs9SPuRHJPO1IqqE9rvo3SXwVNib9Ik0NwGJfhYUw4QS+JmswqNhoAeyzFwh37WYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bELou2lK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4366C43609;
	Wed, 14 Feb 2024 17:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707933491;
	bh=susKoy4B5RTliSEK+0G1W/v7LQ+gMOaRTK0A7H27Nhg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bELou2lKM+XsSyuaT5I4WVuvzLq8h5j5xVB9PvbKBTF8vys9Cvq8XFakVDaQMh2lF
	 48xB1/YjC/WrrwOK9Wpar7AB58uKw6Z2P497C6d4lTqIJmB3i2MZbucurnSy5OV+V4
	 fMkykL4WbMO1aRYlczePUXoxbYOoYKywr4fyXlUDu6I31Ob7Z5W6TU1QmnVqpSxWl4
	 5vaJGqh32yzEEmHewDl3fuxYGUw9bXVP4auvUL4sCNRoOMgbWrRr4B0gMrqmEHTEtA
	 6f1OTe/DyW3tXgrYSqx7Az7ygOmuorW0dQ5D8bhY9zy/nspkI2XvQkLD/jX9HFZRx9
	 CjWvrN/9hBLtw==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
	Unnathi Chalicheemala <quic_uchalich@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@quicinc.com,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH] soc: qcom: llcc: Check return value on Broadcast_OR reg read
Date: Wed, 14 Feb 2024 11:57:39 -0600
Message-ID: <170793345797.27225.11887794025007050941.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202-fix_llcc_update_act_ctrl-v1-1-d36df95c8bd5@quicinc.com>
References: <20240202-fix_llcc_update_act_ctrl-v1-1-d36df95c8bd5@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 02 Feb 2024 11:47:43 -0800, Unnathi Chalicheemala wrote:
> Commit a3134fb09e0b ("drivers: soc: Add LLCC driver") didn't
> check return value after Broadcast_OR register read in
> llcc_update_act_ctrl(), add it.
> 
> 

Applied, thanks!

[1/1] soc: qcom: llcc: Check return value on Broadcast_OR reg read
      commit: ceeaddc19a90039861564d8e1078b778a8f95101

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

