Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100B37EB6B2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 20:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjKNTBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 14:01:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKNTBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 14:01:20 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13AD1F7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 11:01:17 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-41cc7b67419so37501351cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 11:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek.ca; s=google; t=1699988476; x=1700593276; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ln8BfCEw41joQaCUa9COZIwEZXTxudxf07hjQ7uch88=;
        b=U9wNyt0yGDgl0KcgehWtnzDbSJ4lIxs5yYUzd8G5grGasiypLykNl5ku2MVQIpltgD
         bmXsQ3cAf5EjTgGvo9eulV/v5eAWz7TE3nUQJo0kMLVKvGhNNrVf695kQgaF19aw2Dr/
         tdq39/lPbwifXB1Jgp7nRnumbQfOi9hj7WlfuhKZshRDB2uf19RdJHkoEyhkGZs2JxtL
         pffVFrHu+fRf5w4S63tpZ+wpmr+W7TcVAxPR/inhVnUI6WCOIDNjqxqPlKCsFvT0AyuY
         QkBq3B29jfw1FniYT/PkkE3n39x/XUU1GxNiDAaZjJFMszVOj87w35EEN+sLqNeUxRd+
         JmEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699988476; x=1700593276;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ln8BfCEw41joQaCUa9COZIwEZXTxudxf07hjQ7uch88=;
        b=HkWALzAn0PlifBscaxn+oxZDM6K2oYTOcnOg9OQZfhowDuNL+JOK9b9UT7yYoiKBKQ
         Q2/7rhNJFxIm3aynGbAxZ2X8/RxnakaAxgIJIZ6XTeS67e40MQ+cIEeAG5AuXgRBuno8
         yuz12G8PbcMQ3PqJeGGiZsKVAiGoWBQYIBJmBy9390RDryF1v0otgXrdVvXAUHltbQHP
         uA6X3+cpS/wogXqGGBXWb2cuPwFQZEXrZwdcey247pNZxjuEZvvM6cW9KodIb6W/iWlu
         n+8/07Qk4DX5CHYLrzQftEyuId2zlBzc1Fr35a1WtxHMXoQgRf3nZdTbTsE2MQspe1xR
         24FQ==
X-Gm-Message-State: AOJu0Ywhq860ZHSC1n/Wc6QL2fshLGJNfMiNEkjoS/+kKTZzaKjBJTP9
        f+GTBOwp5XHPPh6eskj1si/xqRoCx2F8NBzvAZA=
X-Google-Smtp-Source: AGHT+IEZY0mszhjE/XG+0ap4RZgrAiwX+iNlMgnQL+4jhxs+Ugv/XtWsq8FnNFrQ9qJKcauRm5C8IQ==
X-Received: by 2002:ac8:5a93:0:b0:421:b37c:fdd5 with SMTP id c19-20020ac85a93000000b00421b37cfdd5mr3468998qtc.53.1699988475970;
        Tue, 14 Nov 2023 11:01:15 -0800 (PST)
Received: from [192.168.0.189] (modemcable125.110-19-135.mc.videotron.ca. [135.19.110.125])
        by smtp.gmail.com with ESMTPSA id o24-20020ac85558000000b004198ae7f841sm2944733qtr.90.2023.11.14.11.01.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Nov 2023 11:01:15 -0800 (PST)
Subject: Re: [PATCH 4/4] drm/msm/dsi: fix DSC for the bonded DSI case
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        Doug Anderson <dianders@chromium.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20231114174218.19765-1-jonathan@marek.ca>
 <20231114174218.19765-4-jonathan@marek.ca>
 <eanx45rnasj7lu3r2tfhtg4qkqkcidd6zctsz6ci6jlklu4fgi@3nf73w2ka4li>
From:   Jonathan Marek <jonathan@marek.ca>
Message-ID: <a9712ef1-5f60-b127-a276-9e437d95914f@marek.ca>
Date:   Tue, 14 Nov 2023 14:00:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <eanx45rnasj7lu3r2tfhtg4qkqkcidd6zctsz6ci6jlklu4fgi@3nf73w2ka4li>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14/23 1:28 PM, Marijn Suijten wrote:
> On what hardware have you been testing this?  Dmitry and I have a stack of
> patches to resolve support for Active CTL programming on newer hardware (DPU
> 5.0+ IIRC), where a single CTL is responsible for programming multiple INTF and
> DSC blocks as used in bonded DSI.
> 

I am also using DPU 6+ but I won't be posting patches for DPU to support 
this as I am not using the upstream DPU codebase.

> On 2023-11-14 12:42:16, Jonathan Marek wrote:
>> For the bonded DSI case, DSC pic_width and timing calculations should use
>> the width of a single panel instead of the total combined width.
>>
>> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
>> ---
>>   drivers/gpu/drm/msm/dsi/dsi.h         |  3 ++-
>>   drivers/gpu/drm/msm/dsi/dsi_host.c    | 20 +++++++++++---------
>>   drivers/gpu/drm/msm/dsi/dsi_manager.c |  2 +-
>>   3 files changed, 14 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/dsi/dsi.h b/drivers/gpu/drm/msm/dsi/dsi.h
>> index 28379b1af63f..3a641e69447c 100644
>> --- a/drivers/gpu/drm/msm/dsi/dsi.h
>> +++ b/drivers/gpu/drm/msm/dsi/dsi.h
>> @@ -93,7 +93,8 @@ int msm_dsi_host_power_off(struct mipi_dsi_host *host);
>>   int msm_dsi_host_set_display_mode(struct mipi_dsi_host *host,
>>   				  const struct drm_display_mode *mode);
>>   enum drm_mode_status msm_dsi_host_check_dsc(struct mipi_dsi_host *host,
>> -					    const struct drm_display_mode *mode);
>> +					    const struct drm_display_mode *mode,
>> +					    bool is_bonded_dsi);
>>   unsigned long msm_dsi_host_get_mode_flags(struct mipi_dsi_host *host);
>>   int msm_dsi_host_register(struct mipi_dsi_host *host);
>>   void msm_dsi_host_unregister(struct mipi_dsi_host *host);
>> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
>> index 7284346ab787..a6286eb9d006 100644
>> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
>> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
>> @@ -938,8 +938,7 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
>>   			       mode->hdisplay, mode->vdisplay);
>>   			return;
>>   		}
>> -
>> -		dsc->pic_width = mode->hdisplay;
>> +		dsc->pic_width = hdisplay;
> 
> In my testing and debugging on CMDmode panels downstream this value/register
> was always programmed to the _full_ width of the bonded panel.  Is that maybe
> different for video mode?
> 

downstream dual DSI panel timings are specified for a single panel 
("qcom,mdss-dsi-panel-width" is for a single panel, not both panels)

>>   		dsc->pic_height = mode->vdisplay;
>>   		DBG("Mode %dx%d\n", dsc->pic_width, dsc->pic_height);
>>   
>> @@ -950,6 +949,11 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
>>   		if (ret)
>>   			return;
>>   
>> +		if (msm_host->mode_flags & MIPI_DSI_MODE_VIDEO)
>> +			dsi_update_dsc_timing(msm_host, false, hdisplay);
>> +		else
>> +			dsi_update_dsc_timing(msm_host, true, hdisplay);
>> +
> 
> Such cleanups (which appear unrelated) should probably be posted as separate
> patches.
> 
> - Marijn
> 

Its not unrelated, dsi_update_dsc_timing call is moved up so it can use 
the single-panel "hdisplay" value before it gets adjusted for DSC.

>>   		/* Divide the display by 3 but keep back/font porch and
>>   		 * pulse width same
>>   		 */
>> @@ -966,9 +970,6 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
>>   	}
>>   
>>   	if (msm_host->mode_flags & MIPI_DSI_MODE_VIDEO) {
>> -		if (msm_host->dsc)
>> -			dsi_update_dsc_timing(msm_host, false, mode->hdisplay);
>> -
>>   		dsi_write(msm_host, REG_DSI_ACTIVE_H,
>>   			DSI_ACTIVE_H_START(ha_start) |
>>   			DSI_ACTIVE_H_END(ha_end));
>> @@ -987,9 +988,6 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
>>   			DSI_ACTIVE_VSYNC_VPOS_START(vs_start) |
>>   			DSI_ACTIVE_VSYNC_VPOS_END(vs_end));
>>   	} else {		/* command mode */
>> -		if (msm_host->dsc)
>> -			dsi_update_dsc_timing(msm_host, true, mode->hdisplay);
>> -
>>   		/* image data and 1 byte write_memory_start cmd */
>>   		if (!msm_host->dsc)
>>   			wc = hdisplay * dsi_get_bpp(msm_host->format) / 8 + 1;
>> @@ -2487,7 +2485,8 @@ int msm_dsi_host_set_display_mode(struct mipi_dsi_host *host,
>>   }
>>   
>>   enum drm_mode_status msm_dsi_host_check_dsc(struct mipi_dsi_host *host,
>> -					    const struct drm_display_mode *mode)
>> +					    const struct drm_display_mode *mode,
>> +					    bool is_bonded_dsi)
>>   {
>>   	struct msm_dsi_host *msm_host = to_msm_dsi_host(host);
>>   	struct drm_dsc_config *dsc = msm_host->dsc;
>> @@ -2497,6 +2496,9 @@ enum drm_mode_status msm_dsi_host_check_dsc(struct mipi_dsi_host *host,
>>   	if (!msm_host->dsc)
>>   		return MODE_OK;
>>   
>> +	if (is_bonded_dsi)
>> +		pic_width = mode->hdisplay / 2;
>> +
>>   	if (pic_width % dsc->slice_width) {
>>   		pr_err("DSI: pic_width %d has to be multiple of slice %d\n",
>>   		       pic_width, dsc->slice_width);
>> diff --git a/drivers/gpu/drm/msm/dsi/dsi_manager.c b/drivers/gpu/drm/msm/dsi/dsi_manager.c
>> index 896f369fdd53..2ca1a7ca3659 100644
>> --- a/drivers/gpu/drm/msm/dsi/dsi_manager.c
>> +++ b/drivers/gpu/drm/msm/dsi/dsi_manager.c
>> @@ -455,7 +455,7 @@ static enum drm_mode_status dsi_mgr_bridge_mode_valid(struct drm_bridge *bridge,
>>   			return MODE_ERROR;
>>   	}
>>   
>> -	return msm_dsi_host_check_dsc(host, mode);
>> +	return msm_dsi_host_check_dsc(host, mode, IS_BONDED_DSI());
>>   }
>>   
>>   static const struct drm_bridge_funcs dsi_mgr_bridge_funcs = {
>> -- 
>> 2.26.1
>>
