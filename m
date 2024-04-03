Return-Path: <linux-kernel+bounces-129563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD95896C99
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 733191C271F0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A6B1482EC;
	Wed,  3 Apr 2024 10:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="j+A7gdKs"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3CB134CCA;
	Wed,  3 Apr 2024 10:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712140325; cv=none; b=DYNAWxRO6OxfE6vLvv3BH+uAmCHkiCydllohh0yIiXG++sAKjyFRHSCZ01Xyu2y8/aXMFO5awvr/DmxwDJQeozU90QghiqfLg7/zeRNREQqt6cGh3ZDbEMG2FaLSRxZ+2ZAnPNNZFNLZKQAmSeJD9bZJaL33tO3ywir087G0cTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712140325; c=relaxed/simple;
	bh=QCQv4SlWwu4pTHP3KZHi48pp2atYllgOS/M1veC+SRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JW8SK7QSlKzC8dCEx7CITC0mR7qHaNHU021QIzhdClUT5cxzLmQtr8GicEWFKDcjcdxl82K86HRslfOy2GliS1RkYPur9h8rCY4JtiMT+N2zdOtCiRiO3xuKKGNR45LFevQCR7bs7ZAUPfiCEYMeL9Dkrjl5tKbA+51RQokYYBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=j+A7gdKs; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712140322;
	bh=QCQv4SlWwu4pTHP3KZHi48pp2atYllgOS/M1veC+SRM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j+A7gdKsl4qbgkvz+dyY3uNMPiP+lPeH6p0M1oF1lRq1mpjO3WCmazIKjjkN6bhL/
	 5ERyifQx+RvukIa94tQyJAFDavIFOyWKyIxiJTtu5GrsuOrt7XuWPr/daII/5bNq77
	 Dhp/6VnS9KMKqpCYgdrk36d0R/mNDxsNPe7CxPGT4PCjTu0Gb2nCAJRMuR1+ksTn2q
	 tegKHEzdkez05aQPFbDvu+R9/rbTm5XE4M0oID3vsRN/YKxG2JAonOdVri52rO9p53
	 XsqFt1p3A6CXr+mKJyC+SQPg2WiTT7hxffUXtEejvOx/ajWKWCKTv39KA8BpTj1MAM
	 3KLcFDBfNWhQA==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 25BD93780624;
	Wed,  3 Apr 2024 10:32:02 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Moudy Ho <moudy.ho@mediatek.com>,
	"Jason-JH . Lin" <jason-jh.lin@mediatek.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: (subset) [PATCH v2 00/12] Remove cl in struct cmdq_pkt
Date: Wed,  3 Apr 2024 12:31:57 +0200
Message-ID: <171213938049.123698.15573779837703602591.b4-ty@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240222154120.16959-1-chunkuang.hu@kernel.org>
References: <20240222154120.16959-1-chunkuang.hu@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 22 Feb 2024 15:41:08 +0000, Chun-Kuang Hu wrote:
> cl in struct cmdq_pkt is used to store struct cmdq_client, but every client
> driver has the struct cmdq_client information, so it's not necessary to
> store struct cmdq_client in struct cmdq_pkt. Because mailbox maintainer
> do not like to mix mailbox patch with other patches in a series, so
> mailbox patch [1] would be sent independently.
> 
> Changes in v2:
> 1. Fix typo of CMDQ_JUMP_RELATIVE
> 2. Refine cmdq_pkt_create() and cmdq_pkt_destroy()
> 3. Rename cmdq_pkt_jump() to cmdq_pkt_jump_abs()
> 4. Add cmdq_pkt_jump_rel() helper function
> 5. drm/mediatek: Use cmdq_pkt_create() and cmdq_pkt_destroy()
> 6. mtk-mdp3: Get fine-grain control of cmdq_pkt_finalize()
> 7. mtk-mdp3: Use cmdq_pkt_create() and cmdq_pkt_destroy()
> 
> [...]

Applied to v6.9-next/soc, thanks!

[01/12] soc: mediatek: cmdq: Fix typo of CMDQ_JUMP_RELATIVE
        commit: 7349d4bdee457715308e6229a674f4cebf42be92
[02/12] soc: mediatek: cmdq: Add parameter shift_pa to cmdq_pkt_jump()
        commit: e24e0ff0871b8e3287f258b76b82238b64714628
[03/12] soc: mediatek: cmdq: Rename cmdq_pkt_jump() to cmdq_pkt_jump_abs()
        commit: 8a8bcf23b3e0ab333bfc827ea7ed2f9bece9bea8
[04/12] soc: mediatek: cmdq: Add cmdq_pkt_jump_rel() helper function
        commit: 78462e312e63c5bc0859934d9457155fb50da2e1
[05/12] soc: mediatek: cmdq: Add cmdq_pkt_eoc() helper function
        commit: cad76fa0221c3f8e656b56b7673ae752a65108d8
[06/12] soc: mediatek: cmdq: Remove cmdq_pkt_flush_async() helper function
        commit: 3e2b3be190ace43841011ec0bec950a28a012601
[07/12] soc: mediatek: cmdq: Refine cmdq_pkt_create() and cmdq_pkt_destroy()
        commit: 62d2fb402b132e52899f52b4d5f150fd1dfd1895

Cheers,
Angelo


