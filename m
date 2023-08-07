Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1B53771E68
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 12:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbjHGKnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 06:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjHGKnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 06:43:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED29E76;
        Mon,  7 Aug 2023 03:43:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFFC6617A8;
        Mon,  7 Aug 2023 10:43:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19753C433C7;
        Mon,  7 Aug 2023 10:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691404984;
        bh=lmODyoRJKtcj4W24Dy7/v+c4Qi+PYMon9fdimxp0sfA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TcAlo+cX6hfeF5SQjcMoJTO/A3veK/VokyY/xoYVELPGtPmAfZr3lv5EKQnc+nlKl
         N9DfLtgJiO0p+FxuZiWGLCthpEAOHDN1beOfa7BRs4inIEr36QtWmDDuwDkEytuYUY
         HECYro3S5eSBPetbByRDw3EPrGFIZRGwhmedZ3A5ll7A6jVQjTVL1Z6MntVAQEiLgk
         GpLoeaLn3CgTN7DvNktJ8quypGM2/aTH7eRWtZiagMfPIxwYoFosUpfcFLhynRROxO
         SvJVIylIvWH3Uqvq2d7uqS2bX0QaLexDcXjvYQkBJGnalkgxv7HbKxOJHiLz/2Ffhr
         i2wmRN4CXuhlw==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qSxhX-0005L0-14;
        Mon, 07 Aug 2023 12:43:03 +0200
Date:   Mon, 7 Aug 2023 12:43:03 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] media: platform: venus: Add optional LLCC path
Message-ID: <ZNDKtwO3tWNIFIhz@hovoldconsulting.com>
References: <20230731-topic-8280_venus-v1-0-8c8bbe1983a5@linaro.org>
 <20230731-topic-8280_venus-v1-4-8c8bbe1983a5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731-topic-8280_venus-v1-4-8c8bbe1983a5@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 10:09:11PM +0200, Konrad Dybcio wrote:

> @@ -479,12 +488,18 @@ static __maybe_unused int venus_runtime_suspend(struct device *dev)
>  	if (ret)
>  		goto err_cpucfg_path;
>  
> +	ret = icc_set_bw(core->llcc_path, 0, 0);
> +	if (ret)
> +		goto err_llcc_path;
> +
>  	ret = icc_set_bw(core->video_path, 0, 0);
>  	if (ret)
>  		goto err_video_path;
>  
>  	return ret;
>  
> +err_llcc_path:
> +	icc_set_bw(core->video_path, kbps_to_icc(20000), 0);

This looks wrong; you should not try to restore the video path bw which
you have not yet updated here.

Also error labels should be named after what they do, not after where
you jump from (e.g. to avoid mistakes like the above). Perhaps you can
clean up the existing labels before adding the new one.

>  err_video_path:
>  	icc_set_bw(core->cpucfg_path, kbps_to_icc(1000), 0);
>  err_cpucfg_path:

Johan
