Return-Path: <linux-kernel+bounces-137582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BE589E441
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 22:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0760C1C227B1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 20:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DA21581F8;
	Tue,  9 Apr 2024 20:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="TbkQOHxC"
Received: from sonic313-47.consmr.mail.gq1.yahoo.com (sonic313-47.consmr.mail.gq1.yahoo.com [98.137.65.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31733158207
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 20:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.65.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712693720; cv=none; b=o6eu7glPdCceXC4e3S+GV2q0c4X1VpMk11f2DWT/UHgcVRmQ5uOviVwumZrzFcvk7S+unlr2UaynDHJl/UyqJl7R2rh+SQtEdUCEBgzyBluREO2NdfhrWd1HlKJGY1Auqgf8J0pDB76ucKCdv4uiwyCZlv03Y48M0FcgPe0KY0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712693720; c=relaxed/simple;
	bh=a8ddZuehFg84N+6V98u1My4a2+ltnFQLXir6FRaBgSQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:References; b=Ym2JgQHrruv1NVgp9sb325+DES2bTg4gOg2QdpweVscY7GxknEFIIdrR7WYpKzmgalr6Gk5Pnw/4ATTZSgqe/61Is6sAhZqjf+MvxB4EAOiM+Knrg8eAzkd1enyOBmeZGQxNJwWB2Q+RhHCshYDTlv7MTXU9YvBvb81Q8rDPkjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com; spf=pass smtp.mailfrom=aol.co.uk; dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b=TbkQOHxC; arc=none smtp.client-ip=98.137.65.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aol.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1712693718; bh=pVMCX21u0wBc9yldyEKLn3Oo8MQzZsaUhaZmg/so+oY=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=TbkQOHxCFZJt9pERYzFd/k3fJFA8Zi/N2kjvWeAMRiHwvoYECvBSuCNvQ0OlHPRfTpfPBKdxy/OISGMGGe338kAgi0cdvERPExis+itPL7eEAUJXprmj3nIgSKsOCwBeLKfvZ4R7GmK/bHJyDD6+agPzBztO1Z6q/jHl6Sbyv9A2Em38OExykMgziNyVxen3Ymr2+1M1vgLEDwg8IMAXcFe4CxGEKfM1EJA140q5hTGu+vnnjduDErDerEShcCqWwXnbgJxNa9FvmyX5qrcyBHAHpUoYmPn4Mjb4qWG6lA1L0RSw8Kzrkrt0q9V+z0dh9mPQTXMxteDE7O75BHTNXQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1712693718; bh=Nh/OlTcqOrSy9bbKva1ZIOeCg1jJoY2Q3FPiEXPkiiN=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=MZPdIcVLXz+YqVq/8sae6NV6b7CtxwnAYp39lY3x/di4Il/JPZ9Qff4QPQU7k3xjSIpcZ54ubzQ0m+q4J1yPIk7wo5otLl7IeYBi3HGcy9pg+h4ldDsyRKwe1lHHQBGejndqHnaQUuDISt27srNbYkqIRzu/qyQcE6wWw8HEl7cRsxpLw/+NqTe0O+PAtQ//uXiCZgnnOVled0Ef47Te840kGqZnuXiBZC4bM1RYRmtSr+3LBOH7j0UHagXKIK5Zo7kn8/gSuTcUxCgTzY7uVeRrMowsuaHE4X/RTozLz2OHR28wgDMxjQ91MNeERTezFKjHpWUCIL56cgrWn+jWlw==
X-YMail-OSG: H8HCUMUVM1noYKYq9pam_9mAHVCFEQ0kfI0TQFRy1CVEGVr4g8aCR.vOpDggtW.
 1CtD3qRtSRmDYxZ_5RL1rE6W8z.6AqeLoUp6PxfBH2WcXDrynxwLa9DsKB62xrGjWWiUj9oU..0l
 8wW.q7HRey7KCRh6AbzCRGOY3ECnYFp0rGrzzLQW_SMfs57zCP5S.rqTeZ3ptJHiPNEXpnked5BR
 .u6RHpMyMetA45iiKXDUReY2zkUOXYQXVpYkWDBZ2dqwlDSslXqCyrJ.j9JPpknFabt5U0APXjiN
 pZWMm_zSD9tsLkPblF71rk5QPbNyN5BrB0HB1tfQLlg5C2Dte0bgJH2UVleA5PHeVoiIhixyeWv1
 Mni3kF8TL_KhDQiuj.W0hJfH9hJx4xMq6.7iucVmQWSncecOjqhW.wSi0kv_OYOzEeky9pcoEy1U
 usS2kbQ15OeIrOna_bs6gt0bmxp61wU8OkZI2W.tmw6k5YCU6IQ6jOPqrgPc0pmE1G1t4WVwn0qq
 Dy0AQHg7QaJaqtpMrQca7FXPx_cbekUBdzJuHmC.U8TYd9fKy1PMam6WNmrlyrg.LhxlEppdlPnv
 5gnVoaS65FCKghCMtSpTfaWqoQv.xUHFNKX8XL_QVd.Z_hZAabJ19PkObSNBWMn9lM2qWp.A4w0I
 0EPdgxZQA2RoS0e.GVu_FizQcQiTtT6VrKguTxjDPD7E.6psZL5Dm.1L6wzVE1HChrNSWvLY_4Jy
 rZ25JGl9qRrPBBLNld8.71JV8pKmC1AoME1CcDM145e1EwGEeFSyLTjKRgtitvQKcuWyp_xH6amB
 FVUofWLZ_8nmOWu2QVNq_nSqKKsxuhp3c7zxQ8i_90oCR.MVszfARK65IYqbvGGEAX.zUGpYNzRo
 vV4WeU9H20xuPwGiQWv9A_G5LOMsYK7rxJGcHWDKlbzl5wFMrFxUbIfERk4M3haX6j9aj656sqt5
 nNk4R2pMIIBuAfPNdMaUf9q9X_PeWnLSDCZuik5yFFCAPA_bb1qcsYxRPbtKiwFynPW2FqO3XCEI
 jHJ5EMDYtYiOMnEKZspuCj6iKSXR8PV0EDNB32GzcHWCfZZQG87JVND1CEfUJ_K2ooWQmtLwcy3u
 WxuLyla3b1jtt3cLrUohp3Ek5y0oOFhd8c__2WtikLDQ8bFoRT_CmDT39suACkkVzsAMZQ5jCQfh
 QzURodjD8sC0lDYHefiGNaoiy1e5_c_4EHuq6ab_I7JRuNkbEYyVTiRfSqnHMgEB6B4znhLyQ_Wr
 GVKLYl4zt.gUdULEIlcG3IodfghiyDfUvjypHOfXfvCRfFIwkOycdK3wV2Kbl9mpClrZYdgs_w.z
 Eb_pf30KB6d2xzFLmSZyl8jwtqHaJxlaJ8UnRsSBtviIZgZqyqy97wFHmCAmAdC4Fcslh35Zf5ee
 JXOYmtw0FOkP_7rohmU79RWmdFrJPy8GFhc1YZcRM4Qgbh76rlbFAt6olSVmKBEPBUMknF5m7z2F
 sg88h09sikiS.sdtyXtBn9Ng7_ljnn_W0FOwx4bcBrt2_grlfo_FRdI_ug340xWoYJh5.aw7OEWp
 6VE5lVVN2BUgRAjwigCfnYz0k0n1vlbRVVZgpGqnfgWBLByoYgKQW82ca_l5TYx2gtWowIIa7VtS
 khzF554apq2d8UkieG._o9Ivk0th2cKxM7dx1xq7lsZMiDwl_KhGbFHUCkibToamd7y2lmJr74pr
 90rsXJOi_iP.DNTZeWXKGpmANtmhKbdaXlehb4kDlH9YDNtcQIcpIUik9N8vaYtgJbeUoB.LnGq4
 co2OXu_a6wraMKFidSY6aMyzyKzCh2In2GalfZqQPqFJDEfdZV5AXnSn4dxng9m.cpmzHZEo2FAd
 ox6_4yRGzCrKEbo.A3.IWdMaCkBB3XseD3f4bz4DOgrF2fo8ipVpqI60uWOWupMY45RKu6nNnDne
 wMe3M4gnRtx9QAVP9KWBUl8NY_D2l8GieyLLR7M.swht9flwChw5KcI9ON.NdDqXiKJjoZdnWYsb
 dee9HAsxH1iyrZX5Kpy35L7I3qWk2xCMCgTO_b_J19GsNbNIYAngZQGfKAh5N1pl1.cIYfnW7yHZ
 vGAyyz81jfUZpgTgVkzVgkpW9yR8X3vqh4JK8r3iIB3q6FM.7zVIXj536KSc3FHsjdWZu_KbV96s
 DCHZ2zaWM0PqZ2K5bgTYNDVYBGRXx7EFydLQvTCP_2s_kSkC_TlDPpPX5xSMs67Rk_cWiNsviDTg
 cdVWwYJq95.FjS8nk6Xue779eoiZCqoHm9NDZHcLCXS7UkixDSH08nD2P
X-Sonic-MF: <rubenru09@aol.co.uk>
X-Sonic-ID: adb324b8-0163-488d-a0b9-d8a02d971dbf
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.gq1.yahoo.com with HTTP; Tue, 9 Apr 2024 20:15:18 +0000
Received: by hermes--production-bf1-7d6dbd57c9-rgkn7 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ce6b28aff7bdb6bbe07e2f9d9b252da5;
          Tue, 09 Apr 2024 19:53:02 +0000 (UTC)
From: Ruben Wauters <rubenru09@aol.com>
To: David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: Ruben Wauters <rubenru09@aol.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH] drm/dp_mst: Remove unnecessary vcpi documentation
Date: Tue,  9 Apr 2024 20:51:30 +0100
Message-Id: <20240409195130.25057-1-rubenru09@aol.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20240409195130.25057-1-rubenru09.ref@aol.com>

Since vcpi has been moved into the atomic payload and
out of the port struct, the documentation of vcpi on
the port struct is no longer necessary, and is flagged
as a warning by make htmldocs

Vcpi is also documented elsewhere in this file, in the
atomic payload struct itself

Signed-off-by: Ruben Wauters <rubenru09@aol.com>
---
 include/drm/display/drm_dp_mst_helper.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/drm/display/drm_dp_mst_helper.h b/include/drm/display/drm_dp_mst_helper.h
index 9b19d8bd520a..3ae88a383a41 100644
--- a/include/drm/display/drm_dp_mst_helper.h
+++ b/include/drm/display/drm_dp_mst_helper.h
@@ -83,7 +83,6 @@ struct drm_dp_mst_branch;
  * @passthrough_aux: parent aux to which DSC pass-through requests should be
  * sent, only set if DSC pass-through is possible.
  * @parent: branch device parent of this port
- * @vcpi: Virtual Channel Payload info for this port.
  * @connector: DRM connector this port is connected to. Protected by
  * &drm_dp_mst_topology_mgr.base.lock.
  * @mgr: topology manager this port lives under.
-- 
2.40.1


