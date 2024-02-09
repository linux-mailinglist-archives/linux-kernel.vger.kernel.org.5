Return-Path: <linux-kernel+bounces-59756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 431EB84FB56
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3FC7284769
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D130B7F495;
	Fri,  9 Feb 2024 17:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PvFQAnHO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D4369E16;
	Fri,  9 Feb 2024 17:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707501496; cv=none; b=czn0VEVn6PJ98bMqCM+pyLZUP1P+AMC2QdCeH+C28F/dJFAUeiYziXjUCkBIOKcM+sTDW2dnPGz3vDbYbIT7swB5XY5oFrrjJyzAckCClm6Y2q8FQARHjYea4YAYpZKGhi5y2afYXRlxkIZejKdy9iDXD0xpxM+OIeOCyifG+Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707501496; c=relaxed/simple;
	bh=YirC2f31kUVzy7OmHHopMKCrFhAPdgAOAszsllnydvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ug3qOQJgKdDU0kIizwD81EARa8phbnahxiVPjNKvtN/3YaQNKoKUYn3F16zFukifgNqVHa+AttYf/6oXqmYrhED0O7+VYC2gp3yBA5pjYM2BXylQSkDlMrDaugtI4fHpz3r57TDoCmSUuC/9eoDo+1YHRAdDaU6Cxm5AUFJJMJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PvFQAnHO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE7B0C433C7;
	Fri,  9 Feb 2024 17:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707501495;
	bh=YirC2f31kUVzy7OmHHopMKCrFhAPdgAOAszsllnydvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PvFQAnHOL0+6UuYknRUeRcGhsAcwDpNQzs5POygAofOX6ntvGfv6kqdUwRWdoy9F+
	 1BMlfzUZaxntOzpDuwX5mVzX/EPFa8CTJlHEaleMWpP/aDWoOkXfVGyDVdxmA/Rn0g
	 7SubNx24UzTO39ojjfJwdkCxwHhaMQoiNvya0teowY+ZQq+QBCUQiOKZYsiY2AfHE7
	 15EqF978H8Ws3jQNAu6YST23h0JviPOZAKhRLjklVZD+SisG3FDVZUmaAtB9ZxpcQc
	 QSU8dv4f24G4DF44oySIvHJaMzw9YXftjhCFkB2pQ2VM9l6zWHA/nuVnKeMZAp/FSZ
	 kVbWGD9MOwo4Q==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Caleb Connolly <caleb.connolly@linaro.org>,
	Naina Mehta <quic_nainmeht@quicinc.com>,
	Komal Bajaj <quic_kbajaj@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 0/2] Correcting the voltage setting for vph_pwr
Date: Fri,  9 Feb 2024 11:58:12 -0600
Message-ID: <170750148919.570911.15283827575129692255.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231220110015.25378-1-quic_kbajaj@quicinc.com>
References: <20231220110015.25378-1-quic_kbajaj@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 20 Dec 2023 16:30:13 +0530, Komal Bajaj wrote:
> Correcting the voltage setting for vph_pwr for qcm6490-idp and
> qcs6490-rb3gen2 boards.
> 
> Komal Bajaj (2):
>   arm64: dts: qcom: qcm6490-idp: Correct the voltage setting for vph_pwr
>   arm64: dts: qcom: qcs6490-rb3gen2: Correct the voltage setting for
>     vph_pwr
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: qcom: qcm6490-idp: Correct the voltage setting for vph_pwr
      commit: aa56130e88de50773f84de4039c7de81ab783744
[2/2] arm64: dts: qcom: qcs6490-rb3gen2: Correct the voltage setting for vph_pwr
      commit: 05f439c0e64b877c1f9cc7f0bed894b6df45d43d

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

