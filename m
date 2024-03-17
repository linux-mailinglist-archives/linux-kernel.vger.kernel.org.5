Return-Path: <linux-kernel+bounces-105469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9AD87DE75
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 17:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8ED62823FC
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 16:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E011D539;
	Sun, 17 Mar 2024 16:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K3AM7ez6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2221CF8D;
	Sun, 17 Mar 2024 16:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710692847; cv=none; b=D80x4AvIUxmMlxhK/z6wdWewn86IWZ58c3eegEbcGGe0WOuw1VgnQYJFg4h7/giV64IWuEuVFzKsjXMUoxesMraqSsj+ZbJtYS4H8R+r0eNVY9MCXTstgBAS0K28Hp3WRy+PjpDh+vj+19rIaMuFC8Tpfe8Ja9XI7EIZJVyIOSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710692847; c=relaxed/simple;
	bh=27b4hlI4WVrl3Vmvz0wh8OMrbMtXF4kn/OE1t3LC8lg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QNWo8XAm1C9nPtevKTEoz86A2tYcP1fVFTYheKt/e6z4Z9HlZTTvYnbVMWFdmU1n4PjJgKxc/+ujZj6y9X0KDsv8JbLwGvbM1f1AdX0RhM+558EOlFzlKQeSIXL7eG9appZrT3UxUCF307rHKWdKxK9+LIzOe1h6KsqRFMwahQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K3AM7ez6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A43BEC433C7;
	Sun, 17 Mar 2024 16:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710692847;
	bh=27b4hlI4WVrl3Vmvz0wh8OMrbMtXF4kn/OE1t3LC8lg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K3AM7ez6FjWtx/wAV926cLvLb/NsyY6j2t3XFM9EOl9gjUipxha68JgygjrrGh7PU
	 DztTnwW93oEHcffLy8jBdbjnxY2iIqIXOhFe/Rl3Fk72NkB2JF43J/uTW8ADZmnfWY
	 J02mVHAeK71CDgZe9fMkVL1ZiLKmIxkgIRQs3Wrnexh8mYd/7J+9XcBLtporPaTeDq
	 jH1EsBXY6F0Ew1Rxk1Agcee+GFQ/KljlvvnwZz1gcZAkb/CbFApgKeJ3b+ZPiIOib/
	 iB1UIY87JFdUfLBAS0zm3LqZyFqVItMSFjLy+hoy7zyEKQxM6bUDWPBcZFBZ9myAaw
	 6X2wR83E0L9hw==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Gabor Juhos <j4g8y7@gmail.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: qcom_scm: remove IS_ERR() checks from qcom_scm_bw_{en,dis}able()
Date: Sun, 17 Mar 2024 11:27:18 -0500
Message-ID: <171069283518.134123.17425854027960478350.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240308-qcom_scm-is_err-check-v1-1-9c3e1ceefafe@gmail.com>
References: <20240308-qcom_scm-is_err-check-v1-1-9c3e1ceefafe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 08 Mar 2024 10:25:07 +0100, Gabor Juhos wrote:
> Since the qcom_scm_probe() function returns with an error if
> __scm->path contains an error pointer, it is not needed to
> verify that again in the qcom_scm_bw_{en,dis}able() functions
> so remove the superfluous IS_ERR() checks.
> 
> 

Applied, thanks!

[1/1] firmware: qcom_scm: remove IS_ERR() checks from qcom_scm_bw_{en,dis}able()
      commit: e6f3dac9cf11eff1daddeaa69521370c8941a5f9

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

