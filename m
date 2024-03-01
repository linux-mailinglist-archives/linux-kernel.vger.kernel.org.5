Return-Path: <linux-kernel+bounces-87757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6974F86D898
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 02:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B50EB224AD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 01:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4085A2B9DA;
	Fri,  1 Mar 2024 01:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZ/2Ws/4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812711E891;
	Fri,  1 Mar 2024 01:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709255822; cv=none; b=grmcoU+RGKG8TKaXTtWSqmq/HJcN2B7UJqyIqmm608uWHrG+HBS8UW4yvFsqZsuftzfbaDCNfjR4wjCnjyEw/C6Z2lkVRayqckuZCboyFN2o5lx4Fm2wJrvSjRzt769SclzjxQTxb1zvH98EotFQiAzCj4JxtqQXAHyihgkghO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709255822; c=relaxed/simple;
	bh=QWYpNuusQOi5MlDVFLKyNzFQD9134n7hgqc8OuJDn7w=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=R3yYhAoH4ijvrLUImkrhtJhVQUyFlUXZEwyDSB41OT6RfV0W/4Pe0brMKAZZL/cKhL1cbMnp6DD2aQWXbKOZRIVyrhGN2Teug8VMpghqHlR6QuPB5nueaCJEagVX2oaTQ927LGH59bqTFsQ1MpSO7ZFRh/P9ZUnCrWieqHvMGmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZ/2Ws/4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1D3CC433C7;
	Fri,  1 Mar 2024 01:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709255822;
	bh=QWYpNuusQOi5MlDVFLKyNzFQD9134n7hgqc8OuJDn7w=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=gZ/2Ws/4uINbDgqzQzTBVPomEekSjvrt17lijYhUY/NKn5VSWurS4h9EFbUan4zlP
	 mdJpetoPpm5ICjxbaw4RQwqsguxh59u5WoBm21Fpk17rCPAn8DMXo7P2rWUg6ihd2W
	 ZmF2gG6n6qxAWIv9aGItnIOkUm6Mk/Y2nrXTzPhlkjSeJ4cNyB/Tx5XtOP3RlyM/+E
	 Hq4Hy3g3fXH0kGkFbiucsVrHcGlUg2GoMVQj3mt7wTxjoiJ6ekP/rP8R/LDRm6F6kx
	 DAynPlriCXnbGZ3y2esMDdbBUcxw5dz+R90Nxsr0GZhW8Q4eSeHyHaEZv6tQQlyV5F
	 bDYCMQ94qc3Mg==
Message-ID: <822c03f36eb19376bdd292395c7ecdde.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240229-freq-table-terminator-v1-1-074334f0905c@gmail.com>
References: <20240229-freq-table-terminator-v1-0-074334f0905c@gmail.com> <20240229-freq-table-terminator-v1-1-074334f0905c@gmail.com>
Subject: Re: [PATCH 1/7] clk: qcom: gcc-ipq5018: fix terminating of frequency table arrays
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, Gabor Juhos <j4g8y7@gmail.com>
To: Anusha Rao <quic_anusha@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Devi Priya <quic_devipriy@quicinc.com>, Gabor Juhos <j4g8y7@gmail.com>, Georgi Djakov <gdjakov@mm-sol.com>, Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>, Konrad Dybcio <konrad.dybcio@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Sricharan Ramabadhran <quic_srichara@quicinc.com>, Varadarajan Narayanan <quic_varada@quicinc.com>
Date: Thu, 29 Feb 2024 17:16:59 -0800
User-Agent: alot/0.10

Quoting Gabor Juhos (2024-02-29 10:07:46)
> The frequency table arrays are supposed to be terminated with an
> empty element. Add such entry to the end of the arrays where it
> is missing in order to avoid possible out-of-bound access when
> the table is traversed by functions like qcom_find_freq() or
> qcom_find_freq_floor().
>=20
> Fixes: e3fdbef1bab8 ("clk: qcom: Add Global Clock controller (GCC) driver=
 for IPQ5018")
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

