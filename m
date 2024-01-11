Return-Path: <linux-kernel+bounces-23356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD1382AB88
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A7801F23243
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F1F12E5B;
	Thu, 11 Jan 2024 10:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XtbLBQ1s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0139210A14;
	Thu, 11 Jan 2024 10:05:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB533C433C7;
	Thu, 11 Jan 2024 10:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704967505;
	bh=ejfpJMtejqF7iTeQRs32sW6QKpxHOspsw5qIUc8L8L8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=XtbLBQ1sODZpr5AfAtsfLyJzKL3XQWdfRKIsgkgBSZp09KkeoRNzlrIcM/WgtZoXJ
	 oRnZDzg5/TCEsUhfb+DrpYbQS8hgxN7A1iAn//Xku9n9cveXIsJ06obOQRrJNdGaP8
	 21uBqf+mcX3O9CU816UfMiRg/1EbFkaJ/LcuFUMaSJ1adBTpI2h0lQks5B871hgXaB
	 kRHutNWGg67nnXUWIDLfxgla1gb0ooonyS/g+V7BqAhMCddnZoziY290N/I9Yf6Fw3
	 +swu0mV1GZMLouevulYmukZK7XJ5jAvRwbiVvTvL5VByU+GtepSzciHQXuN0NcbXQD
	 rFBG1Nbf7zL+w==
From: Lee Jones <lee@kernel.org>
To: pavel@ucw.cz, lee@kernel.org, thierry.reding@gmail.com, 
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
 agross@kernel.org, andersson@kernel.org, 
 Anjelique Melendez <quic_amelende@quicinc.com>
Cc: luca.weiss@fairphone.com, konrad.dybcio@linaro.org, 
 u.kleine-koenig@pengutronix.de, quic_subbaram@quicinc.com, 
 quic_gurus@quicinc.com, linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org
In-Reply-To: <20231221185838.28440-1-quic_amelende@quicinc.com>
References: <20231221185838.28440-1-quic_amelende@quicinc.com>
Subject: Re: (subset) [PATCH v8 0/7] Add support for LUT PPG
Message-Id: <170496750168.1654525.11132648331912183091.b4-ty@kernel.org>
Date: Thu, 11 Jan 2024 10:05:01 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3

On Thu, 21 Dec 2023 10:58:30 -0800, Anjelique Melendez wrote:
> In certain PMICs, LUT pattern and LPG configuration is stored in SDAM
> modules instead of LUT peripheral. This feature is called PPG.
> 
> This change series adds support for PPG. Thanks!
> Changes since v7:
>   - Patch 4/7
>     - Initialize hi/lo_pause variables in lpg_pattern_set()
> Changes since v6:
>   - Patch 2/7
>     - Removed required by constraint on PPG dt properties
> Changes since v5:
>   - Patch 4/7
>     - Update logic so that multicolor led device triggers pattern
>       on all LEDs at the same time
>     - Update nitpicks from Lee
>   - Patch 5/7
>     - Update nitpicks from Lee
> Changes since v4:
>   - Patch 3/7
>     - Get rid of r/w helpers
>     - Use regmap_read_poll_timeout() in qcom_pbs_wait_for_ack()
>     - Update error path in qcom_pbs_trigger_event()
>     - Fix reverse christmas tree
>   - Patch 4/7
>     - Get rid of r/w helpers
>     - Update variables to use "sdam" instead of "nvmem"
>     - Fix comments
>     - Fix reverse christmas tree
>     - Update lpg_pattern_set() logic
>   - Patch 5/7
>     - Removed sdam_lut_base from lpg_data
> Changes since v3:
>   - Patch 4/7
>     - Fix function returns
>     - Move register definition to top of file
>     - Revert max_brightness and probe accidental changes
>     - Combine init_sdam() and parse_sdam()
>     - Change error prints in probe to use dev_err_probe
>     - Remove ppg_en variable
>     - Update when pbs triggers are set/cleared
>   - Patch 6/7
>     - Remove use of nvmem_count
>     - Move register definition to top of file
>     - Remove lpg_get_sdam_lut_idx()
> Changes since v2:
>   - Patch 1/7
>     - Fix dt_binding_check error
>     - Rename binding file to match compatible
>     - Iclude SoC specific comptaibles
>   - Patch 2/7
>     - Update nvmem-names list
>   - Patch 3/7
>     - Update EXPORT_SYMBOL to EXPORT_SYMBOL_GPL
>     - Fix return/break logic in qcom_pbs_wait_for_ack()
>     - Update iterators to be int
>     - Add constants
>     - Fix function calls in qcom_pbs_trigger_event()
>     - Remove unnessary comments
>     - Return -EPROBE_DEFER from get_pbs_client_device()
> Changes since v1:
>   - Patch 1/7
>     - Fix dt_binding_check errors
>     - Update binding description
>   - Path 2/7
>     - Fix dt_binding_check errors
>     - Update per variant constraints
>     - Update nvmem description
>   - Patch 3/7
>     - Update get_pbs_client_device()
>     - Drop use of printk
>     - Remove unused function
> 
> [...]

Applied, thanks!

[2/7] dt-bindings: leds: leds-qcom-lpg: Add support for LPG PPG
      commit: 2fdd08fec742e0c94a2a06a0c9ee0912b6f7ac39
[4/7] leds: rgb: leds-qcom-lpg: Add support for PPG through single SDAM
      commit: 07a1afc8fbb77cc893e2285112482902ac88a295
[5/7] leds: rgb: leds-qcom-lpg: Update PMI632 lpg_data to support PPG
      commit: f4f5f6a6f8d7bcc8efd0eee6751def22c9a38fd0
[6/7] leds: rgb: leds-qcom-lpg: Include support for PPG with dedicated LUT SDAM
      commit: 7399a927272de1fc42f4da8af1d8d60b65a15b84
[7/7] leds: rgb: Update PM8350C lpg_data to support two-nvmem PPG Scheme
      commit: 7b4066868689b1f341e61957611d252b6fa8cafc

--
Lee Jones [李琼斯]


