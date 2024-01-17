Return-Path: <linux-kernel+bounces-29131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDE483094B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 16:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E18241C22503
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207DD22329;
	Wed, 17 Jan 2024 15:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FEOWh83q"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90512231D;
	Wed, 17 Jan 2024 15:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705504334; cv=none; b=OjjyTAJWz8Q4O3D/RJOSpzzUa6WJdjG4+8omG6df8zFgDetIgRqswlPlJTEwlGYXvH0iloxCj5xraXikrV7M0wmkNellvArGpRL8G60TsH6h3EXdY7Xp1Lw+U1iTYW8SV0OqF/OsXU5kFHEUcbRJBQ+Q/FCahRAxjP290NTEyRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705504334; c=relaxed/simple;
	bh=KJL7fJjmSJOdFxPriDXpzXsW8jCVL1vlFWIgAEf+FPk=;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=sVw9deqnXzVS2XYH/UU2uoeQOVRvNf3lwa91/B6Bd22tMlP495vYWJZZ3Ux6y2GZBD6Yhbw8qij4bxki/NYdGNlcpdPoS+xTOpCQ75CZDB5duLC3SdsTeFPjFpQ0horhXH0e3CNcr06H7nDyIpYK2WVFqUJEytaRvbAUvXBUr0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FEOWh83q; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705504331;
	bh=KJL7fJjmSJOdFxPriDXpzXsW8jCVL1vlFWIgAEf+FPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FEOWh83qwtH/f/B0y1VcRZYp3s6j9NQSxFxqsXtJB5AsVUu8Gy/50VLAnhzSrVKLV
	 OOdRYGUklUIVMEWoWzBjehlq0B6RWxnYJjfaRrCdCXjMdAktn/XfbKYlnwSJDYrOQr
	 M4s87hozrkTxh5hxc8a5eZBrMuZoN0XN+i0TnWlrTfnB8icvHZTHmkqamgtlw+/Sr8
	 q9oG22AuVaFvIrMdPyhfrOdPyW+ya3Xu7zSTlNJszmTcTaKRtGfALZrGs+rZAx9Duk
	 bsoMaTQ7fQPwC2Q4+m7kipRfYMiK+3cqdf+EgkolWH0PKiNPxuGelvTSzDSFF6ouoU
	 JfXcb/GmzRIzA==
Received: from arisu.hitronhub.home (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id DDFE03782033;
	Wed, 17 Jan 2024 15:12:09 +0000 (UTC)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: linux-media@vger.kernel.org,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH v5 1/4] media: visl,vidtv: Set parameters permissions to 0444
Date: Wed, 17 Jan 2024 10:10:15 -0500
Message-ID: <20240117151202.405426-2-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240117151202.405426-1-detlev.casanova@collabora.com>
References: <20240117151202.405426-1-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This avoids confusion with default values and lets userspace
programs get the modules parameters values at run time.

This can be useful when setting up a test suite.

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 .../media/test-drivers/vidtv/vidtv_bridge.c   | 26 +++++++++----------
 drivers/media/test-drivers/visl/visl-core.c   | 10 +++----
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/media/test-drivers/vidtv/vidtv_bridge.c b/drivers/media/test-drivers/vidtv/vidtv_bridge.c
index 8b04e12af286..613949df897d 100644
--- a/drivers/media/test-drivers/vidtv/vidtv_bridge.c
+++ b/drivers/media/test-drivers/vidtv/vidtv_bridge.c
@@ -45,28 +45,28 @@
 #define LNB_HIGH_FREQ		10600000	/* transition frequency */
 
 static unsigned int drop_tslock_prob_on_low_snr;
-module_param(drop_tslock_prob_on_low_snr, uint, 0);
+module_param(drop_tslock_prob_on_low_snr, uint, 0444);
 MODULE_PARM_DESC(drop_tslock_prob_on_low_snr,
 		 "Probability of losing the TS lock if the signal quality is bad");
 
 static unsigned int recover_tslock_prob_on_good_snr;
-module_param(recover_tslock_prob_on_good_snr, uint, 0);
+module_param(recover_tslock_prob_on_good_snr, uint, 0444);
 MODULE_PARM_DESC(recover_tslock_prob_on_good_snr,
 		 "Probability recovering the TS lock when the signal improves");
 
 static unsigned int mock_power_up_delay_msec;
-module_param(mock_power_up_delay_msec, uint, 0);
+module_param(mock_power_up_delay_msec, uint, 0444);
 MODULE_PARM_DESC(mock_power_up_delay_msec, "Simulate a power up delay");
 
 static unsigned int mock_tune_delay_msec;
-module_param(mock_tune_delay_msec, uint, 0);
+module_param(mock_tune_delay_msec, uint, 0444);
 MODULE_PARM_DESC(mock_tune_delay_msec, "Simulate a tune delay");
 
 static unsigned int vidtv_valid_dvb_t_freqs[NUM_VALID_TUNER_FREQS] = {
 	474000000
 };
 
-module_param_array(vidtv_valid_dvb_t_freqs, uint, NULL, 0);
+module_param_array(vidtv_valid_dvb_t_freqs, uint, NULL, 0444);
 MODULE_PARM_DESC(vidtv_valid_dvb_t_freqs,
 		 "Valid DVB-T frequencies to simulate, in Hz");
 
@@ -74,19 +74,19 @@ static unsigned int vidtv_valid_dvb_c_freqs[NUM_VALID_TUNER_FREQS] = {
 	474000000
 };
 
-module_param_array(vidtv_valid_dvb_c_freqs, uint, NULL, 0);
+module_param_array(vidtv_valid_dvb_c_freqs, uint, NULL, 0444);
 MODULE_PARM_DESC(vidtv_valid_dvb_c_freqs,
 		 "Valid DVB-C frequencies to simulate, in Hz");
 
 static unsigned int vidtv_valid_dvb_s_freqs[NUM_VALID_TUNER_FREQS] = {
 	11362000
 };
-module_param_array(vidtv_valid_dvb_s_freqs, uint, NULL, 0);
+module_param_array(vidtv_valid_dvb_s_freqs, uint, NULL, 0444);
 MODULE_PARM_DESC(vidtv_valid_dvb_s_freqs,
 		 "Valid DVB-S/S2 frequencies to simulate at Ku-Band, in kHz");
 
 static unsigned int max_frequency_shift_hz;
-module_param(max_frequency_shift_hz, uint, 0);
+module_param(max_frequency_shift_hz, uint, 0444);
 MODULE_PARM_DESC(max_frequency_shift_hz,
 		 "Maximum shift in HZ allowed when tuning in a channel");
 
@@ -96,24 +96,24 @@ DVB_DEFINE_MOD_OPT_ADAPTER_NR(adapter_nums);
  * Influences the signal acquisition time. See ISO/IEC 13818-1 : 2000. p. 113.
  */
 static unsigned int si_period_msec = 40;
-module_param(si_period_msec, uint, 0);
+module_param(si_period_msec, uint, 0444);
 MODULE_PARM_DESC(si_period_msec, "How often to send SI packets. Default: 40ms");
 
 static unsigned int pcr_period_msec = 40;
-module_param(pcr_period_msec, uint, 0);
+module_param(pcr_period_msec, uint, 0444);
 MODULE_PARM_DESC(pcr_period_msec,
 		 "How often to send PCR packets. Default: 40ms");
 
 static unsigned int mux_rate_kbytes_sec = 4096;
-module_param(mux_rate_kbytes_sec, uint, 0);
+module_param(mux_rate_kbytes_sec, uint, 0444);
 MODULE_PARM_DESC(mux_rate_kbytes_sec, "Mux rate: will pad stream if below");
 
 static unsigned int pcr_pid = 0x200;
-module_param(pcr_pid, uint, 0);
+module_param(pcr_pid, uint, 0444);
 MODULE_PARM_DESC(pcr_pid, "PCR PID for all channels: defaults to 0x200");
 
 static unsigned int mux_buf_sz_pkts;
-module_param(mux_buf_sz_pkts, uint, 0);
+module_param(mux_buf_sz_pkts, uint, 0444);
 MODULE_PARM_DESC(mux_buf_sz_pkts,
 		 "Size for the internal mux buffer in multiples of 188 bytes");
 
diff --git a/drivers/media/test-drivers/visl/visl-core.c b/drivers/media/test-drivers/visl/visl-core.c
index 68dac896277b..12e93a7798d1 100644
--- a/drivers/media/test-drivers/visl/visl-core.c
+++ b/drivers/media/test-drivers/visl/visl-core.c
@@ -64,27 +64,27 @@ MODULE_PARM_DESC(visl_transtime_ms, " simulated process time in milliseconds.");
  * particular number of frames
  */
 int visl_dprintk_frame_start = -1;
-module_param(visl_dprintk_frame_start, int, 0);
+module_param(visl_dprintk_frame_start, int, 0444);
 MODULE_PARM_DESC(visl_dprintk_frame_start,
 		 " a frame number to start tracing with dprintk");
 
 unsigned int visl_dprintk_nframes;
-module_param(visl_dprintk_nframes, uint, 0);
+module_param(visl_dprintk_nframes, uint, 0444);
 MODULE_PARM_DESC(visl_dprintk_nframes,
 		 " the number of frames to trace with dprintk");
 
 bool keep_bitstream_buffers;
-module_param(keep_bitstream_buffers, bool, false);
+module_param(keep_bitstream_buffers, bool, 0444);
 MODULE_PARM_DESC(keep_bitstream_buffers,
 		 " keep bitstream buffers in debugfs after streaming is stopped");
 
 int bitstream_trace_frame_start = -1;
-module_param(bitstream_trace_frame_start, int, 0);
+module_param(bitstream_trace_frame_start, int, 0444);
 MODULE_PARM_DESC(bitstream_trace_frame_start,
 		 " a frame number to start dumping the bitstream through debugfs");
 
 unsigned int bitstream_trace_nframes;
-module_param(bitstream_trace_nframes, uint, 0);
+module_param(bitstream_trace_nframes, uint, 0444);
 MODULE_PARM_DESC(bitstream_trace_nframes,
 		 " the number of frames to dump the bitstream through debugfs");
 
-- 
2.43.0


