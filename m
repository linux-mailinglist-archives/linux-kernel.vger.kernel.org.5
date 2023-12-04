Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 294AD8035FD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344920AbjLDOG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:06:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235854AbjLDOGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:06:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4D9181
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 06:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701698779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MRL6u6puJliyWIxLTWXft+hWMGexa+EgSP+FNb730mY=;
        b=QBeq5TYB/ARb+1ocKjz+ha+13gIjNvhP4zj6SdFW962a0hJ42zvgzKsN+SGY4fdZRia7pZ
        2s5+ciWLknxEqaEef0f8fMn/CCIuT7dOL/M1GZvFKiD/JX1QY0ddtZ+q9GGFajjO/u6ZTb
        gc3SzoLCcqpjZIPw//UYKB9y929eUAU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-Cusqz4C5M3qcXdykYIwEyw-1; Mon, 04 Dec 2023 09:06:18 -0500
X-MC-Unique: Cusqz4C5M3qcXdykYIwEyw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40b349b9711so38763335e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 06:06:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701698776; x=1702303576;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MRL6u6puJliyWIxLTWXft+hWMGexa+EgSP+FNb730mY=;
        b=oG/NGVm+iyaTK4zd+zERVVrXNmFobc4UiYMkXFf1SMNdALNrCMPJIlfB50vH67OigW
         jVIb65FD62VswFGh2TTHMgdtvbBLwTnL+Sqlb50D+cNClg6gUb1MJMVFrPtinVPYlO/Q
         FTj0X2i29s6GadJOLMfctClkuJvB9iUXtsJlHS1WkuxpECkh56nr2498LQmvGHcJBZAO
         AmS78MwX2GbdTz348igHPRaP16nNL+ehD2WPYVC7hYjg+YA0sRXoRehQEtk87t56nAbp
         PPg7z+aBighVwzx7h+jueFcL/xNYVgomQcdOX2baa3nEsUPxSPDMHxRUDYhOMCPDVbuW
         fUQw==
X-Gm-Message-State: AOJu0YwvuICaaTyGsaqldLx9BBiNxd3x3nV2MhF11dpym+dYE8Lcs7Rg
        vjyPeqoPYSfDYuGXQO+u6GBNZkP04CDF0DkGMp8tiBGEEnljoEC8OjuRkEkpYP/4KcvupNYmmp1
        4CXZicec+4qiVsFb/BBvwMdSJaEihQqWH
X-Received: by 2002:a05:600c:524b:b0:40b:5e21:dd39 with SMTP id fc11-20020a05600c524b00b0040b5e21dd39mr2592514wmb.103.1701698776017;
        Mon, 04 Dec 2023 06:06:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHPCOx4InJD0m8MbLw59ctaAQvfcSrMz2BQznb1FspJ0Q8Hh74Ib5WkmfHNXghTaDJAwjR82Q==
X-Received: by 2002:a05:600c:524b:b0:40b:5e21:dd39 with SMTP id fc11-20020a05600c524b00b0040b5e21dd39mr2592505wmb.103.1701698775723;
        Mon, 04 Dec 2023 06:06:15 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id sa12-20020a1709076d0c00b009fd585a2155sm5307858ejc.0.2023.12.04.06.06.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 06:06:15 -0800 (PST)
Message-ID: <d3b0dd08-4eca-4268-8b13-e60bd3d85524@redhat.com>
Date:   Mon, 4 Dec 2023 15:06:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] platform/x86: ISST: Process read/write blocked
 feature status
Content-Language: en-US
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        markgross@kernel.org, ilpo.jarvinen@linux.intel.com,
        andriy.shevchenko@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231130214751.3100418-1-srinivas.pandruvada@linux.intel.com>
 <20231130214751.3100418-5-srinivas.pandruvada@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231130214751.3100418-5-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/30/23 22:47, Srinivas Pandruvada wrote:
> When a feature is read blocked, don't continue to read SST information
> and register with SST core.
> 
> When the feature is write blocked, continue to offer read interface for
> SST parameters, but don't allow any operation to change state. A state
> change results from SST level change, feature change or class of service
> change.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
> v2
> - Change read_blocked, write_blocked to bool
> - Move the check for power_domain_info->write_blocked for SST-CP
> to only write operations

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Did you drop Ilpo's Reviewed-by from v1 on purpose
because of the changes ? Or did you forget to add it ?

Regards,

Hans


> 
>  .../intel/speed_select_if/isst_tpmi_core.c    | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
> index 0b6d2c864437..2662fbbddf0c 100644
> --- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
> +++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
> @@ -234,6 +234,7 @@ struct perf_level {
>   * @saved_clos_configs:	Save SST-CP CLOS configuration to store restore for suspend/resume
>   * @saved_clos_assocs:	Save SST-CP CLOS association to store restore for suspend/resume
>   * @saved_pp_control:	Save SST-PP control information to store restore for suspend/resume
> + * @write_blocked:	Write operation is blocked, so can't change SST state
>   *
>   * This structure is used store complete SST information for a power_domain. This information
>   * is used to read/write request for any SST IOCTL. Each physical CPU package can have multiple
> @@ -259,6 +260,7 @@ struct tpmi_per_power_domain_info {
>  	u64 saved_clos_configs[4];
>  	u64 saved_clos_assocs[4];
>  	u64 saved_pp_control;
> +	bool write_blocked;
>  };
>  
>  /**
> @@ -515,6 +517,9 @@ static long isst_if_clos_param(void __user *argp)
>  		return -EINVAL;
>  
>  	if (clos_param.get_set) {
> +		if (power_domain_info->write_blocked)
> +			return -EPERM;
> +
>  		_write_cp_info("clos.min_freq", clos_param.min_freq_mhz,
>  			       (SST_CLOS_CONFIG_0_OFFSET + clos_param.clos * SST_REG_SIZE),
>  			       SST_CLOS_CONFIG_MIN_START, SST_CLOS_CONFIG_MIN_WIDTH,
> @@ -602,6 +607,9 @@ static long isst_if_clos_assoc(void __user *argp)
>  
>  		power_domain_info = &sst_inst->power_domain_info[punit_id];
>  
> +		if (assoc_cmds.get_set && power_domain_info->write_blocked)
> +			return -EPERM;
> +
>  		offset = SST_CLOS_ASSOC_0_OFFSET +
>  				(punit_cpu_no / SST_CLOS_ASSOC_CPUS_PER_REG) * SST_REG_SIZE;
>  		shift = punit_cpu_no % SST_CLOS_ASSOC_CPUS_PER_REG;
> @@ -752,6 +760,9 @@ static int isst_if_set_perf_level(void __user *argp)
>  	if (!power_domain_info)
>  		return -EINVAL;
>  
> +	if (power_domain_info->write_blocked)
> +		return -EPERM;
> +
>  	if (!(power_domain_info->pp_header.allowed_level_mask & BIT(perf_level.level)))
>  		return -EINVAL;
>  
> @@ -809,6 +820,9 @@ static int isst_if_set_perf_feature(void __user *argp)
>  	if (!power_domain_info)
>  		return -EINVAL;
>  
> +	if (power_domain_info->write_blocked)
> +		return -EPERM;
> +
>  	_write_pp_info("perf_feature", perf_feature.feature, SST_PP_CONTROL_OFFSET,
>  		       SST_PP_FEATURE_STATE_START, SST_PP_FEATURE_STATE_WIDTH,
>  		       SST_MUL_FACTOR_NONE)
> @@ -1257,11 +1271,21 @@ static long isst_if_def_ioctl(struct file *file, unsigned int cmd,
>  
>  int tpmi_sst_dev_add(struct auxiliary_device *auxdev)
>  {
> +	bool read_blocked = 0, write_blocked = 0;
>  	struct intel_tpmi_plat_info *plat_info;
>  	struct tpmi_sst_struct *tpmi_sst;
>  	int i, ret, pkg = 0, inst = 0;
>  	int num_resources;
>  
> +	ret = tpmi_get_feature_status(auxdev, TPMI_ID_SST, &read_blocked, &write_blocked);
> +	if (ret)
> +		dev_info(&auxdev->dev, "Can't read feature status: ignoring read/write blocked status\n");
> +
> +	if (read_blocked) {
> +		dev_info(&auxdev->dev, "Firmware has blocked reads, exiting\n");
> +		return -ENODEV;
> +	}
> +
>  	plat_info = tpmi_get_platform_data(auxdev);
>  	if (!plat_info) {
>  		dev_err(&auxdev->dev, "No platform info\n");
> @@ -1306,6 +1330,7 @@ int tpmi_sst_dev_add(struct auxiliary_device *auxdev)
>  		tpmi_sst->power_domain_info[i].package_id = pkg;
>  		tpmi_sst->power_domain_info[i].power_domain_id = i;
>  		tpmi_sst->power_domain_info[i].auxdev = auxdev;
> +		tpmi_sst->power_domain_info[i].write_blocked = write_blocked;
>  		tpmi_sst->power_domain_info[i].sst_base = devm_ioremap_resource(&auxdev->dev, res);
>  		if (IS_ERR(tpmi_sst->power_domain_info[i].sst_base))
>  			return PTR_ERR(tpmi_sst->power_domain_info[i].sst_base);

