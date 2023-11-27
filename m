Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D99957F9C03
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 09:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbjK0Io7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 03:44:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbjK0Io5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 03:44:57 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECE610A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 00:45:01 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-332e3664665so2347623f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 00:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701074700; x=1701679500; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dCFjhx9K9/R0Y38cSNvSXo0KIc6d9vHQ6Gy4kjBmWeg=;
        b=Fx29s11Phte3ws7aRtQ7mX8mR2T1L8g4RfDClpYLJEPzCF+SGMnbyLTwtumZhZ6b7N
         MB4ndxoLGLCmu+kJzWmLeBF3DBDol/0omzujTTDfrPOEMXLSm7XCxB6sxBk9yuX7L9d/
         FYCF7FdDFk8i+E5Xl2vWZr6iJjmCV0F6uAhffxikMFlqOs1hi8OXsHA4+XrnVuakOTDy
         HF8UuZFizeXufrAw/cBmmQ3RfPfGOzfCV2sw0u7xxClNZwFvj75Ayuw72u7gZ2RNs0uF
         hxgs1TkrQU8j/HEqzsDu/tZjadZFaWXkMLzUfWlpp40IGqAVyrUfTcipmEHR79L3Xjuf
         44JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701074700; x=1701679500;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dCFjhx9K9/R0Y38cSNvSXo0KIc6d9vHQ6Gy4kjBmWeg=;
        b=W/g8lcW0rA5hW/bLQtmMGk/PSdfr50LTmqi2xE0CiGE1taQ2t5/lyYZJp3D2sfK3yQ
         ynOEt3bFsz3mYhozdSk8G+mT9KCaEkHnNjtIDTIyr5V4qrgKtr+oQMQQuc5HUBOid+oj
         i/CqkE9eExqpDXnznkAHglU6U+LR2jcZSa6Cxt0U7WRC6M9BrYpxd/Pl0i3x99HSd5yc
         x4DVRplf8E6EJxqnn/YM4qgETpakb8ST77sxcBxq3u1xjOxaM7K7WN+gBiY51eBpH7AD
         eYFHMdFTp8bmhgT01T7EkZYg5/4itpyc0cvSufwX113ogOtvWleGwjIGNiZzIjlF2N4y
         8MZg==
X-Gm-Message-State: AOJu0YzHMAwSEZ/9GfJtgqBrXGJ4u12F/mG7TAt9MHxtasRNc8rOMRej
        Os7Vnr34vIZqNzUDbQ/rLZ4XFw==
X-Google-Smtp-Source: AGHT+IGI8Dy+ZyFSO302KGvnBFOT7cdZCPes17VLgW0j4sFDL6AlSPHkMyOx5U+rVHXK1Y8X1PWz/Q==
X-Received: by 2002:a5d:4ac6:0:b0:332:e42e:6dee with SMTP id y6-20020a5d4ac6000000b00332e42e6deemr7620706wrs.71.1701074700006;
        Mon, 27 Nov 2023 00:45:00 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id 2-20020a5d47a2000000b00332ff137c29sm3079100wrb.79.2023.11.27.00.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 00:44:59 -0800 (PST)
From:   Dan Carpenter <dan.carpenter@linaro.org>
X-Google-Original-From: Dan Carpenter <dan.carpenter@oracle.com>
Date:   Mon, 27 Nov 2023 11:44:56 +0300
To:     oe-kbuild@lists.linux.dev,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>
Subject: drivers/firmware/qcom/qcom_qseecom_uefisecapp.c:329
 qsee_uefi_get_variable() warn: possible memory leak of 'rsp_data'
Message-ID: <46f9f073-4127-464a-a9aa-b378ce0d21fb@suswa.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d2da77f431ac49b5763b88751a75f70daa46296c
commit: bdac188ec3c71800dd8419620224ee74ef37732a firmware: qcom: move Qualcomm code into its own directory
config: loongarch-randconfig-r071-20231126 (https://download.01.org/0day-ci/archive/20231127/202311270828.k4HGcjiL-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231127/202311270828.k4HGcjiL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Closes: https://lore.kernel.org/r/202311270828.k4HGcjiL-lkp@intel.com/

smatch warnings:
drivers/firmware/qcom/qcom_qseecom_uefisecapp.c:329 qsee_uefi_get_variable() warn: possible memory leak of 'rsp_data'
drivers/firmware/qcom/qcom_qseecom_uefisecapp.c:475 qsee_uefi_set_variable() warn: possible memory leak of 'rsp_data'
drivers/firmware/qcom/qcom_qseecom_uefisecapp.c:567 qsee_uefi_get_next_variable() warn: possible memory leak of 'rsp_data'

vim +/rsp_data +329 drivers/firmware/qcom/qcom_qseecom_uefisecapp.c

759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  271  static efi_status_t qsee_uefi_get_variable(struct qcuefi_client *qcuefi, const efi_char16_t *name,
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  272  					   const efi_guid_t *guid, u32 *attributes,
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  273  					   unsigned long *data_size, void *data)
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  274  {
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  275  	struct qsee_req_uefi_get_variable *req_data;
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  276  	struct qsee_rsp_uefi_get_variable *rsp_data;
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  277  	unsigned long buffer_size = *data_size;
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  278  	efi_status_t efi_status = EFI_SUCCESS;
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  279  	unsigned long name_length;
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  280  	size_t guid_offs;
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  281  	size_t name_offs;
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  282  	size_t req_size;
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  283  	size_t rsp_size;
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  284  	ssize_t status;
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  285  
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  286  	if (!name || !guid)
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  287  		return EFI_INVALID_PARAMETER;
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  288  
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  289  	name_length = ucs2_strnlen(name, QSEE_MAX_NAME_LEN) + 1;
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  290  	if (name_length > QSEE_MAX_NAME_LEN)
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  291  		return EFI_INVALID_PARAMETER;
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  292  
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  293  	if (buffer_size && !data)
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  294  		return EFI_INVALID_PARAMETER;
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  295  
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  296  	req_size = qcuefi_buf_align_fields(
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  297  		__field(*req_data)
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  298  		__array_offs(*name, name_length, &name_offs)
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  299  		__field_offs(*guid, &guid_offs)
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  300  	);
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  301  
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  302  	rsp_size = qcuefi_buf_align_fields(
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  303  		__field(*rsp_data)
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  304  		__array(u8, buffer_size)
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  305  	);
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  306  
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  307  	req_data = kzalloc(req_size, GFP_KERNEL);
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  308  	if (!req_data) {
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  309  		efi_status = EFI_OUT_OF_RESOURCES;
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  310  		goto out;
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  311  	}
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  312  
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  313  	rsp_data = kzalloc(rsp_size, GFP_KERNEL);
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  314  	if (!rsp_data) {
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  315  		efi_status = EFI_OUT_OF_RESOURCES;
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  316  		goto out_free_req;
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  317  	}
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  318  
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  319  	req_data->command_id = QSEE_CMD_UEFI_GET_VARIABLE;
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  320  	req_data->data_size = buffer_size;
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  321  	req_data->name_offset = name_offs;
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  322  	req_data->name_size = name_length * sizeof(*name);
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  323  	req_data->guid_offset = guid_offs;
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  324  	req_data->guid_size = sizeof(*guid);
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  325  	req_data->length = req_size;
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  326  
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  327  	status = ucs2_strscpy(((void *)req_data) + req_data->name_offset, name, name_length);
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  328  	if (status < 0)
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27 @329  		return EFI_INVALID_PARAMETER;

Should be a goto unwind.  Same for other direct returns.

759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  330  
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  331  	memcpy(((void *)req_data) + req_data->guid_offset, guid, req_data->guid_size);
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  332  
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  333  	status = qcom_qseecom_app_send(qcuefi->client, req_data, req_size, rsp_data, rsp_size);
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  334  	if (status) {
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  335  		efi_status = EFI_DEVICE_ERROR;
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  336  		goto out_free;
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  337  	}
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  338  
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  339  	if (rsp_data->command_id != QSEE_CMD_UEFI_GET_VARIABLE) {
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  340  		efi_status = EFI_DEVICE_ERROR;
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  341  		goto out_free;
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  342  	}
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  343  
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  344  	if (rsp_data->length < sizeof(*rsp_data)) {
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  345  		efi_status = EFI_DEVICE_ERROR;
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  346  		goto out_free;
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  347  	}
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  348  
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  349  	if (rsp_data->status) {
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  350  		dev_dbg(qcuefi_dev(qcuefi), "%s: uefisecapp error: 0x%x\n",
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  351  			__func__, rsp_data->status);
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  352  		efi_status = qsee_uefi_status_to_efi(rsp_data->status);
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  353  
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  354  		/* Update size and attributes in case buffer is too small. */
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  355  		if (efi_status == EFI_BUFFER_TOO_SMALL) {
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  356  			*data_size = rsp_data->data_size;
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  357  			if (attributes)
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  358  				*attributes = rsp_data->attributes;
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  359  		}
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  360  
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  361  		goto out_free;
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  362  	}
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  363  
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  364  	if (rsp_data->length > rsp_size) {
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  365  		efi_status = EFI_DEVICE_ERROR;
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  366  		goto out_free;
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  367  	}
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  368  
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  369  	if (rsp_data->data_offset + rsp_data->data_size > rsp_data->length) {
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  370  		efi_status = EFI_DEVICE_ERROR;
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  371  		goto out_free;
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  372  	}
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  373  
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  374  	/*
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  375  	 * Note: We need to set attributes and data size even if the buffer is
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  376  	 * too small and we won't copy any data. This is described in spec, so
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  377  	 * that callers can either allocate a buffer properly (with two calls
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  378  	 * to this function) or just read back attributes withouth having to
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  379  	 * deal with that.
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  380  	 *
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  381  	 * Specifically:
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  382  	 * - If we have a buffer size of zero and no buffer, just return the
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  383  	 *   attributes, required size, and indicate success.
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  384  	 * - If the buffer size is nonzero but too small, indicate that as an
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  385  	 *   error.
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  386  	 * - Otherwise, we are good to copy the data.
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  387  	 *
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  388  	 * Note that we have already ensured above that the buffer pointer is
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  389  	 * non-NULL if its size is nonzero.
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  390  	 */
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  391  	*data_size = rsp_data->data_size;
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  392  	if (attributes)
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  393  		*attributes = rsp_data->attributes;
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  394  
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  395  	if (buffer_size == 0 && !data) {
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  396  		efi_status = EFI_SUCCESS;
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  397  		goto out_free;
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  398  	}
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  399  
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  400  	if (buffer_size < rsp_data->data_size) {
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  401  		efi_status = EFI_BUFFER_TOO_SMALL;
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  402  		goto out_free;
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  403  	}
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  404  
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  405  	memcpy(data, ((void *)rsp_data) + rsp_data->data_offset, rsp_data->data_size);
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  406  
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  407  out_free:
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  408  	kfree(rsp_data);
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  409  out_free_req:
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  410  	kfree(req_data);
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  411  out:
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  412  	return efi_status;
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  413  }
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  414  
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  415  static efi_status_t qsee_uefi_set_variable(struct qcuefi_client *qcuefi, const efi_char16_t *name,
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  416  					   const efi_guid_t *guid, u32 attributes,
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  417  					   unsigned long data_size, const void *data)
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  418  {
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  419  	struct qsee_req_uefi_set_variable *req_data;
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  420  	struct qsee_rsp_uefi_set_variable *rsp_data;
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  421  	efi_status_t efi_status = EFI_SUCCESS;
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  422  	unsigned long name_length;
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  423  	size_t name_offs;
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  424  	size_t guid_offs;
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  425  	size_t data_offs;
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  426  	size_t req_size;
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  427  	ssize_t status;
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  428  
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  429  	if (!name || !guid)
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  430  		return EFI_INVALID_PARAMETER;
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  431  
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  432  	name_length = ucs2_strnlen(name, QSEE_MAX_NAME_LEN) + 1;
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  433  	if (name_length > QSEE_MAX_NAME_LEN)
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  434  		return EFI_INVALID_PARAMETER;
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  435  
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  436  	/*
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  437  	 * Make sure we have some data if data_size is nonzero. Note that using
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  438  	 * a size of zero is a valid use-case described in spec and deletes the
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  439  	 * variable.
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  440  	 */
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  441  	if (data_size && !data)
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  442  		return EFI_INVALID_PARAMETER;
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  443  
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  444  	req_size = qcuefi_buf_align_fields(
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  445  		__field(*req_data)
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  446  		__array_offs(*name, name_length, &name_offs)
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  447  		__field_offs(*guid, &guid_offs)
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  448  		__array_offs(u8, data_size, &data_offs)
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  449  	);
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  450  
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  451  	req_data = kzalloc(req_size, GFP_KERNEL);
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  452  	if (!req_data) {
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  453  		efi_status = EFI_OUT_OF_RESOURCES;
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  454  		goto out;
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  455  	}
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  456  
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  457  	rsp_data = kzalloc(sizeof(*rsp_data), GFP_KERNEL);
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  458  	if (!rsp_data) {
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  459  		efi_status = EFI_OUT_OF_RESOURCES;
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  460  		goto out_free_req;
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  461  	}
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  462  
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  463  	req_data->command_id = QSEE_CMD_UEFI_SET_VARIABLE;
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  464  	req_data->attributes = attributes;
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  465  	req_data->name_offset = name_offs;
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  466  	req_data->name_size = name_length * sizeof(*name);
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  467  	req_data->guid_offset = guid_offs;
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  468  	req_data->guid_size = sizeof(*guid);
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  469  	req_data->data_offset = data_offs;
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  470  	req_data->data_size = data_size;
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  471  	req_data->length = req_size;
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  472  
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  473  	status = ucs2_strscpy(((void *)req_data) + req_data->name_offset, name, name_length);
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  474  	if (status < 0)
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27 @475  		return EFI_INVALID_PARAMETER;
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  476  
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  477  	memcpy(((void *)req_data) + req_data->guid_offset, guid, req_data->guid_size);
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  478  
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  479  	if (data_size)
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  480  		memcpy(((void *)req_data) + req_data->data_offset, data, req_data->data_size);
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  481  
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  482  	status = qcom_qseecom_app_send(qcuefi->client, req_data, req_size, rsp_data,
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  483  				       sizeof(*rsp_data));
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  484  	if (status) {
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  485  		efi_status = EFI_DEVICE_ERROR;
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  486  		goto out_free;
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  487  	}
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  488  
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  489  	if (rsp_data->command_id != QSEE_CMD_UEFI_SET_VARIABLE) {
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  490  		efi_status = EFI_DEVICE_ERROR;
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  491  		goto out_free;
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  492  	}
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  493  
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  494  	if (rsp_data->length != sizeof(*rsp_data)) {
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  495  		efi_status = EFI_DEVICE_ERROR;
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  496  		goto out_free;
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  497  	}
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  498  
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  499  	if (rsp_data->status) {
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  500  		dev_dbg(qcuefi_dev(qcuefi), "%s: uefisecapp error: 0x%x\n",
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  501  			__func__, rsp_data->status);
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  502  		efi_status = qsee_uefi_status_to_efi(rsp_data->status);
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  503  	}
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  504  
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  505  out_free:
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  506  	kfree(rsp_data);
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  507  out_free_req:
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  508  	kfree(req_data);
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  509  out:
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  510  	return efi_status;
759e7a2b62eb3e drivers/firmware/qcom_qseecom_uefisecapp.c Maximilian Luz 2023-08-27  511  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

