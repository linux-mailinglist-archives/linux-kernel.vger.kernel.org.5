Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11A1E76B9B2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 18:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbjHAQe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 12:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjHAQeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 12:34:25 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E8D1BF9;
        Tue,  1 Aug 2023 09:34:23 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RFgZp3WT4z67kys;
        Wed,  2 Aug 2023 00:30:42 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 1 Aug
 2023 17:34:19 +0100
Date:   Tue, 1 Aug 2023 17:34:18 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Masahisa Kojima <masahisa.kojima@linaro.org>
CC:     Ard Biesheuvel <ardb@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        "Sumit Garg" <sumit.garg@linaro.org>,
        <linux-kernel@vger.kernel.org>, <op-tee@lists.trustedfirmware.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-efi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v7 3/5] efi: Add tee-based EFI variable driver
Message-ID: <20230801173418.00007337@Huawei.com>
In-Reply-To: <20230731065041.1447-4-masahisa.kojima@linaro.org>
References: <20230731065041.1447-1-masahisa.kojima@linaro.org>
        <20230731065041.1447-4-masahisa.kojima@linaro.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jul 2023 15:50:38 +0900
Masahisa Kojima <masahisa.kojima@linaro.org> wrote:

> When the flash is not owned by the non-secure world, accessing the EFI
> variables is straightforward and done via EFI Runtime Variable Services.
> In this case, critical variables for system integrity and security
> are normally stored in the dedicated secure storage and only accessible
> from the secure world.
> 
> On the other hand, the small embedded devices don't have the special
> dedicated secure storage. The eMMC device with an RPMB partition is
> becoming more common, we can use an RPMB partition to store the
> EFI Variables.
> 
> The eMMC device is typically owned by the non-secure world(linux in
> this case). There is an existing solution utilizing eMMC RPMB partition
> for EFI Variables, it is implemented by interacting with
> TEE(OP-TEE in this case), StandaloneMM(as EFI Variable Service Pseudo TA),
> eMMC driver and tee-supplicant. The last piece is the tee-based
> variable access driver to interact with TEE and StandaloneMM.
> 
> So let's add the kernel functions needed.
> 
> This feature is implemented as a kernel module.
> StMM PTA has TA_FLAG_DEVICE_ENUM_SUPP flag when registered to OP-TEE
> so that this tee_stmm_efi module is probed after tee-supplicant starts,
> since "SetVariable" EFI Runtime Variable Service requires to
> interact with tee-supplicant.
> 
> Acked-by: Sumit Garg <sumit.garg@linaro.org>
> Co-developed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>

I was curious - so drive by review. Feel free to ignore :)
All general code readability stuff and a suggestion for the subsystem to
get rid of boilerplate (like most large subsystems did years ago!)

Jonathan


> diff --git a/drivers/firmware/efi/stmm/tee_stmm_efi.c b/drivers/firmware/efi/stmm/tee_stmm_efi.c
> new file mode 100644
> index 000000000000..f6623171ae04
> --- /dev/null
> +++ b/drivers/firmware/efi/stmm/tee_stmm_efi.c

...

> +/**
> + * tee_mm_communicate() - Pass a buffer to StandaloneMM running in TEE
> + *
> + * @comm_buf:		locally allocated communication buffer
> + * @dsize:		buffer size
> + * Return:		status code
> + */
> +static efi_status_t tee_mm_communicate(void *comm_buf, size_t dsize)
> +{
> +	size_t buf_size;
> +	efi_status_t ret;
> +	struct efi_mm_communicate_header *mm_hdr;
> +	struct tee_ioctl_invoke_arg arg;
> +	struct tee_param param[4];
> +	struct tee_shm *shm = NULL;
> +	int rc;
> +
> +	if (!comm_buf)
> +		return EFI_INVALID_PARAMETER;
> +
> +	mm_hdr = (struct efi_mm_communicate_header *)comm_buf;
> +	buf_size = mm_hdr->message_len + sizeof(efi_guid_t) + sizeof(size_t);
> +
> +	if (dsize != buf_size)
> +		return EFI_INVALID_PARAMETER;
> +
> +	shm = tee_shm_register_kernel_buf(pvt_data.ctx, comm_buf, buf_size);
> +	if (IS_ERR(shm)) {
> +		dev_err(pvt_data.dev, "Unable to register shared memory\n");
> +		return EFI_UNSUPPORTED;
> +	}
> +
> +	memset(&arg, 0, sizeof(arg));
> +	arg.func = PTA_STMM_CMD_COMMUNICATE;
> +	arg.session = pvt_data.session;
> +	arg.num_params = 4;
> +
> +	memset(param, 0, sizeof(param));
> +	param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT;
> +	param[0].u.memref.size = buf_size;
> +	param[0].u.memref.shm = shm;
> +	param[1].attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT;
> +	param[2].attr = TEE_IOCTL_PARAM_ATTR_TYPE_NONE;
> +	param[3].attr = TEE_IOCTL_PARAM_ATTR_TYPE_NONE;
> +
> +	rc = tee_client_invoke_func(pvt_data.ctx, &arg, param);
> +	tee_shm_free(shm);
> +
> +	if (rc < 0 || arg.ret != 0) {
> +		dev_err(pvt_data.dev,
> +			"PTA_STMM_CMD_COMMUNICATE invoke error: 0x%x\n", arg.ret);
> +		return EFI_DEVICE_ERROR;
> +	}
> +
> +	switch (param[1].u.value.a) {
> +	case ARM_SVC_SPM_RET_SUCCESS:
> +		ret = EFI_SUCCESS;
> +		break;
> +
> +	case ARM_SVC_SPM_RET_INVALID_PARAMS:
> +		ret = EFI_INVALID_PARAMETER;
> +		break;
> +
> +	case ARM_SVC_SPM_RET_DENIED:
> +		ret = EFI_ACCESS_DENIED;
> +		break;
> +
> +	case ARM_SVC_SPM_RET_NO_MEMORY:
> +		ret = EFI_OUT_OF_RESOURCES;
> +		break;
> +
> +	default:
> +		ret = EFI_ACCESS_DENIED;
> +	}
> +
> +	return ret;

Direct returns both shorter and easier to review!

> +}
> +

Lots of similar stuff to below...


> +
> +static efi_status_t tee_get_variable(u16 *name, efi_guid_t *vendor,
> +				     u32 *attributes, unsigned long *data_size,
> +				     void *data)
> +{
> +	struct var_check_property var_property;
> +	struct smm_variable_access *var_acc;
> +	size_t payload_size;
> +	size_t name_size;
> +	size_t tmp_dsize;
> +	u8 *comm_buf = NULL;
> +	efi_status_t ret;
> +
> +	if (!name || !vendor || !data_size) {
> +		ret = EFI_INVALID_PARAMETER;
> +		goto out;
> +	}
> +
> +	name_size = (ucs2_strnlen(name, EFI_VAR_NAME_LEN) + 1) * sizeof(u16);
> +	if (name_size > max_payload_size - MM_VARIABLE_ACCESS_HEADER_SIZE) {
> +		ret = EFI_INVALID_PARAMETER;
> +		goto out;
> +	}
> +
> +	/* Trim output buffer size */
> +	tmp_dsize = *data_size;
> +	if (name_size + tmp_dsize >
> +	    max_payload_size - MM_VARIABLE_ACCESS_HEADER_SIZE) {
> +		tmp_dsize = max_payload_size - MM_VARIABLE_ACCESS_HEADER_SIZE -
> +			    name_size;
> +	}
> +
> +	/* Get communication buffer and initialize header */
> +	payload_size = MM_VARIABLE_ACCESS_HEADER_SIZE + name_size + tmp_dsize;
> +	var_acc = setup_mm_hdr(&comm_buf, payload_size,
> +			       SMM_VARIABLE_FUNCTION_GET_VARIABLE, &ret);
> +	if (!comm_buf)
> +		goto out;
> +
> +	/* Fill in contents */
> +	memcpy(&var_acc->guid, vendor, sizeof(var_acc->guid));
> +	var_acc->data_size = tmp_dsize;
> +	var_acc->name_size = name_size;
> +	var_acc->attr = attributes ? *attributes : 0;
> +	memcpy(var_acc->name, name, name_size);
> +
> +	/* Communicate */

Comment seems a bit obvious.  General rule, don't comment the obvious. It just
provides places where the comments might become wrong during future refactors.

> +	ret = mm_communicate(comm_buf, payload_size);
> +	if (ret == EFI_SUCCESS || ret == EFI_BUFFER_TOO_SMALL)
> +		/* Update with reported data size for trimmed case */
> +		*data_size = var_acc->data_size;
> +	if (ret != EFI_SUCCESS)
> +		goto out;
> +
> +	ret = get_property_int(name, name_size, vendor, &var_property);
> +	if (ret != EFI_SUCCESS)
> +		goto out;
> +
> +	if (attributes)
> +		*attributes = var_acc->attr;
> +
> +	if (data)
> +		memcpy(data, (u8 *)var_acc->name + var_acc->name_size,
> +		       var_acc->data_size);
> +	else
> +		ret = EFI_INVALID_PARAMETER;

Keep to a simple out of line error flow as it's more readable even when it
is a line or 2 more code.

	if (!data) {
		ret = EFI_INVALID_PARAMETER;
		goto out;
	}
	memcpy()...
> +
> +out:
> +	kfree(comm_buf);
> +	return ret;
> +}
> +
> +static efi_status_t tee_get_next_variable(unsigned long *name_size,
> +					  efi_char16_t *name, efi_guid_t *guid)
> +{
> +	struct smm_variable_getnext *var_getnext;
> +	size_t payload_size;
> +	size_t out_name_size;
> +	size_t in_name_size;
> +	u8 *comm_buf = NULL;
> +	efi_status_t ret;
> +
> +	if (!name_size || !name || !guid) {
> +		ret = EFI_INVALID_PARAMETER;
> +		goto out;

As below.  Direct returns make it clear nothing to do and generally
give easier code to review.

> +	}
> +
> +	out_name_size = *name_size;
> +	in_name_size = (ucs2_strnlen(name, EFI_VAR_NAME_LEN) + 1) * sizeof(u16);
> +
> +	if (out_name_size < in_name_size) {
> +		ret = EFI_INVALID_PARAMETER;
> +		goto out;
> +	}
> +
> +	if (in_name_size >
> +	    max_payload_size - MM_VARIABLE_GET_NEXT_HEADER_SIZE) {
> +		ret = EFI_INVALID_PARAMETER;
> +		goto out;
> +	}
> +
> +	/* Trim output buffer size */
> +	if (out_name_size > max_payload_size - MM_VARIABLE_GET_NEXT_HEADER_SIZE)
> +		out_name_size =
> +			max_payload_size - MM_VARIABLE_GET_NEXT_HEADER_SIZE;
> +
> +	payload_size = MM_VARIABLE_GET_NEXT_HEADER_SIZE + out_name_size;
> +	var_getnext = setup_mm_hdr(&comm_buf, payload_size,
> +				   SMM_VARIABLE_FUNCTION_GET_NEXT_VARIABLE_NAME,
> +				   &ret);
> +	if (!comm_buf)

As below (I'm reviewing up the code)

> +		goto out;
> +
> +	/* Fill in contents */
> +	memcpy(&var_getnext->guid, guid, sizeof(var_getnext->guid));
> +	var_getnext->name_size = out_name_size;
> +	memcpy(var_getnext->name, name, in_name_size);
> +	memset((u8 *)var_getnext->name + in_name_size, 0x0,
> +	       out_name_size - in_name_size);
> +
> +	/* Communicate */
> +	ret = mm_communicate(comm_buf, payload_size);
> +	if (ret == EFI_SUCCESS || ret == EFI_BUFFER_TOO_SMALL) {
> +		/* Update with reported data size for trimmed case */
> +		*name_size = var_getnext->name_size;
> +	}
> +	if (ret != EFI_SUCCESS)
> +		goto out;
> +
> +	memcpy(guid, &var_getnext->guid, sizeof(*guid));
> +	memcpy(name, var_getnext->name, var_getnext->name_size);
> +
> +out:
> +	kfree(comm_buf);
> +	return ret;
> +}
> +
> +static efi_status_t tee_set_variable(efi_char16_t *name, efi_guid_t *vendor,
> +				     u32 attributes, unsigned long data_size,
> +				     void *data)
> +{
> +	efi_status_t ret;
> +	struct var_check_property var_property;
> +	struct smm_variable_access *var_acc;
> +	size_t payload_size;
> +	size_t name_size;
> +	u8 *comm_buf = NULL;
> +
> +	if (!name || name[0] == 0 || !vendor) {
> +		ret = EFI_INVALID_PARAMETER;
> +		goto out;

Nothing to do so why not return here?

> +	}
> +	if (data_size > 0 && !data) {
> +		ret = EFI_INVALID_PARAMETER;
> +		goto out;

Also return here?

> +	}
> +	/* Check payload size */
> +	name_size = (ucs2_strnlen(name, EFI_VAR_NAME_LEN) + 1) * sizeof(u16);
> +	payload_size = MM_VARIABLE_ACCESS_HEADER_SIZE + name_size + data_size;
> +	if (payload_size > max_payload_size) {
> +		ret = EFI_INVALID_PARAMETER;
> +		goto out;
and here.

> +	}
> +
> +	/*
> +	 * Allocate the buffer early, before switching to RW (if needed)
> +	 * so we won't need to account for any failures in reading/setting
> +	 * the properties, if the allocation fails
> +	 */
> +	var_acc = setup_mm_hdr(&comm_buf, payload_size,
> +			       SMM_VARIABLE_FUNCTION_SET_VARIABLE, &ret);
> +	if (!comm_buf)

In this case still nothing to do. Return here - plus ideally check ret
rather than comm_buf so it's clear that an error is being returned without
us having to look in setup_mm_hdr()

> +		goto out;
> +
> +	/*
> +	 * The API has the ability to override RO flags. If no RO check was
> +	 * requested switch the variable to RW for the duration of this call
> +	 */
> +	ret = get_property_int(name, name_size, vendor, &var_property);
> +	if (ret != EFI_SUCCESS) {
> +		dev_err(pvt_data.dev, "Getting variable property failed\n");
> +		goto out;
> +	}
> +
> +	if (var_property.property & VAR_CHECK_VARIABLE_PROPERTY_READ_ONLY) {
> +		ret = EFI_WRITE_PROTECTED;
> +		goto out;
> +	}
> +
> +	/* Fill in contents */
> +	memcpy(&var_acc->guid, vendor, sizeof(var_acc->guid));
> +	var_acc->data_size = data_size;
> +	var_acc->name_size = name_size;
> +	var_acc->attr = attributes;
> +	memcpy(var_acc->name, name, name_size);
> +	memcpy((u8 *)var_acc->name + name_size, data, data_size);
> +

Not sure why 2 blank lines here. One probably fine.

> +
> +	/* Communicate */
> +	ret = mm_communicate(comm_buf, payload_size);
> +	dev_dbg(pvt_data.dev, "Set Variable %s %d %lx\n", __FILE__, __LINE__, ret);
> +out:
> +	kfree(comm_buf);
> +	return ret;
> +}
> +
> +static efi_status_t tee_set_variable_nonblocking(efi_char16_t *name,
> +						 efi_guid_t *vendor,
> +						 u32 attributes,
> +						 unsigned long data_size,
> +						 void *data)
> +{
> +	return EFI_UNSUPPORTED;
> +}
> +
> +static efi_status_t tee_query_variable_info(u32 attributes,
> +					    u64 *max_variable_storage_size,
> +					    u64 *remain_variable_storage_size,
> +					    u64 *max_variable_size)
> +{
> +	struct smm_variable_query_info *mm_query_info;
> +	size_t payload_size;
> +	efi_status_t ret;
> +	u8 *comm_buf;
> +
> +	payload_size = sizeof(*mm_query_info);
> +	mm_query_info = setup_mm_hdr(&comm_buf, payload_size,
> +				SMM_VARIABLE_FUNCTION_QUERY_VARIABLE_INFO,
> +				&ret);
> +	if (!comm_buf)
> +		goto out;

if (!comm_buf) nothing to do (which is good as I'd not expect setup_mm_hdr
to have side effects if it fails.  So return ret.  Which is a little odd.
Can we just use ret as the check instead? That way it's clear the error returned
isn't an accidental success.

> +
> +	mm_query_info->attr = attributes;
> +	ret = mm_communicate(comm_buf, payload_size);
> +	if (ret != EFI_SUCCESS)
> +		goto out;
> +	*max_variable_storage_size = mm_query_info->max_variable_storage;
> +	*remain_variable_storage_size =
> +		mm_query_info->remaining_variable_storage;
> +	*max_variable_size = mm_query_info->max_variable_size;
> +
> +out:
> +	kfree(comm_buf);
> +	return ret;
> +}
> +
> +static int tee_stmm_efi_probe(struct device *dev)
> +{
> +	struct tee_ioctl_open_session_arg sess_arg;
> +	efi_status_t ret;
> +	int rc;
> +
> +	/* Open context with TEE driver */
> +	pvt_data.ctx = tee_client_open_context(NULL, tee_ctx_match, NULL, NULL);
> +	if (IS_ERR(pvt_data.ctx))
> +		return -ENODEV;
> +
> +	/* Open session with StMM PTA */
> +	memset(&sess_arg, 0, sizeof(sess_arg));
> +	export_uuid(sess_arg.uuid, &tee_stmm_efi_id_table[0].uuid);
> +	rc = tee_client_open_session(pvt_data.ctx, &sess_arg, NULL);
> +	if ((rc < 0) || (sess_arg.ret != 0)) {
> +		dev_err(dev, "tee_client_open_session failed, err: %x\n",
> +			sess_arg.ret);
> +		rc = -EINVAL;
> +		goto out_ctx;

Up to you, but I'd be tempted to take this all devm_ managed
via devm_add_action_or_reset() and suitable callbacks.

Marginal benefit in lines of code but makes it much harder to forget
to tidy something up in some future refactoring / reordering of code.

> +	}
> +	pvt_data.session = sess_arg.session;
> +	pvt_data.dev = dev;
> +
> +	ret = get_max_payload(&max_payload_size);
> +	if (ret != EFI_SUCCESS) {
> +		rc = -EIO;
> +		goto out_sess;
> +	}
> +
> +	max_buffer_size = MM_COMMUNICATE_HEADER_SIZE +
> +			  MM_VARIABLE_COMMUNICATE_SIZE +
> +			  max_payload_size;
> +
> +	tee_efivar_ops.get_variable = tee_get_variable;
> +	tee_efivar_ops.get_next_variable = tee_get_next_variable;
> +	tee_efivar_ops.set_variable = tee_set_variable;
> +	tee_efivar_ops.set_variable_nonblocking = tee_set_variable_nonblocking;
> +	tee_efivar_ops.query_variable_store = efi_query_variable_store;
> +	tee_efivar_ops.query_variable_info = tee_query_variable_info;
> +
> +	efivars_generic_ops_unregister();
> +	pr_info("Use tee-based EFI runtime variable services\n");
> +	efivars_register(&tee_efivars, &tee_efivar_ops);
> +
> +	return 0;
> +
> +out_sess:
> +	tee_client_close_session(pvt_data.ctx, pvt_data.session);
> +out_ctx:
> +	tee_client_close_context(pvt_data.ctx);
> +
> +	return rc;
> +}
> +
> +static int tee_stmm_efi_remove(struct device *dev)
> +{
> +	efivars_unregister(&tee_efivars);
> +	efivars_generic_ops_register();
> +
> +	tee_client_close_session(pvt_data.ctx, pvt_data.session);
> +	tee_client_close_context(pvt_data.ctx);
> +
> +	return 0;
> +}
> +
> +MODULE_DEVICE_TABLE(tee, tee_stmm_efi_id_table);
> +
> +static struct tee_client_driver tee_stmm_efi_driver = {
> +	.id_table	= tee_stmm_efi_id_table,
> +	.driver		= {
> +		.name		= "tee-stmm-efi",
> +		.bus		= &tee_bus_type,
> +		.probe		= tee_stmm_efi_probe,
> +		.remove		= tee_stmm_efi_remove,
> +	},
> +};
> +
> +static int __init tee_stmm_efi_mod_init(void)
> +{
> +	return driver_register(&tee_stmm_efi_driver.driver);
> +}
> +
> +static void __exit tee_stmm_efi_mod_exit(void)
> +{
> +	driver_unregister(&tee_stmm_efi_driver.driver);
> +}
> +
> +module_init(tee_stmm_efi_mod_init);
> +module_exit(tee_stmm_efi_mod_exit);

Looks like tee client drivers could benefit from a 
#define module_tee_client_driver(__tee_client_driver) 
similar to module_platform_driver() and similar.
 
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Ilias Apalodimas <ilias.apalodimas@linaro.org>");
> +MODULE_AUTHOR("Masahisa Kojima <masahisa.kojima@linaro.org>");
> +MODULE_DESCRIPTION("TEE based EFI runtime variable service driver");

