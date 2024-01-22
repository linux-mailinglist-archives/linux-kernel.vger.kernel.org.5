Return-Path: <linux-kernel+bounces-32756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98434835FBA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C61C21C24390
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C5B38DD8;
	Mon, 22 Jan 2024 10:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VXYiQi5z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05821DFF3;
	Mon, 22 Jan 2024 10:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705919468; cv=none; b=O9gSOp8Bpxl56woXLbsBUV+Oh0zvsjnZGk0eqClIXy9T/KL8NYV+p2rJuAJuQ/Lg1AWEVLFMw6F5Exbj6ASOavF2VwjrDqQW+coKwQhTbPQlRHjtqLkXkDg5iKD17AnKE0Ssydhg5XCI7eZQsihk/zV9rJBYbiD8XRcNK/BT5tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705919468; c=relaxed/simple;
	bh=Adk4o/syB8kwb6hMdHdd8CxVfC3VENFja8OPDajgNt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hMW/rcA1rWoxzNrt1smP4YO5GJu7aMmVEdoFjeykTygwCLT0sLMus8Ibu5pdwmeR7hDuzD1QUz2aFmdUdvNnNkRYVbkuDeNA254tQyXNQHurI811NnEZKJRepV+aVxGBtq/fO3Gw12oKjHzcCG697W5vDeJ+K+IaibCZj5ph1ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VXYiQi5z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F258C43390;
	Mon, 22 Jan 2024 10:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705919468;
	bh=Adk4o/syB8kwb6hMdHdd8CxVfC3VENFja8OPDajgNt8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VXYiQi5zdrm6D/arV+leoLROlbr7Rb91J3KkdLkhJFacvol55XCXpGBRHkReoQ+wS
	 MkW8a9h0UGD2duiJuDVOIRQc078qQhCdjKiWa7YZ0JajQZT3g7KahEljOb9k9u4+L0
	 SarFw28EbOctK+w9oDuislDN8TCphzc4XCNBhJM2xZHh4GJsXbOdYpiurVhYnFUbSZ
	 hDzRTkr8ZuZ39SzKyQg1H82b1R5/uANddhFrvfCs4Uxxn1eX18NofmN0nwOXZi936R
	 6fNa0KMEOiAcpeAHyHYvOfNhPE6/J+R7WSebFfcC47s9rnezA6PZInjFYR6EvpMXUq
	 c/Nbd7OHGXp9g==
Date: Mon, 22 Jan 2024 10:31:00 +0000
From: Simon Horman <horms@kernel.org>
To: Danielle Ratson <danieller@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net,
	linux@armlinux.org.uk, sdf@google.com, kory.maincent@bootlin.com,
	maxime.chevallier@bootlin.com, vladimir.oltean@nxp.com,
	przemyslaw.kitszel@intel.com, ahmed.zaki@intel.com,
	richardcochran@gmail.com, shayagr@amazon.com,
	paul.greenwalt@intel.com, jiri@resnulli.us,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	mlxsw@nvidia.com, petrm@nvidia.com, idosch@nvidia.com
Subject: Re: [RFC PATCH net-next 7/9] ethtool: cmis_cdb: Add a layer for
 supporting CDB commands
Message-ID: <20240122103100.GA126470@kernel.org>
References: <20240122084530.32451-1-danieller@nvidia.com>
 <20240122084530.32451-8-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122084530.32451-8-danieller@nvidia.com>

On Mon, Jan 22, 2024 at 10:45:28AM +0200, Danielle Ratson wrote:

..

> +/**
> + * struct ethtool_cmis_cdb_request - CDB commands request fields as decribed in
> + *				the CMIS standard
> + * @id: Command ID.
> + * @epl_len: EPL memory length.
> + * @lpl_len: LPL memory length.
> + * @chk_code: Check code for the previous field and the payload.
> + * @resv1: Added to match the CMIS standard request continuity.
> + * @resv2: Added to match the CMIS standard request continuity.
> + * @payload: Payload for the CDB commands.
> + */
> +struct ethtool_cmis_cdb_request {
> +	__be16 id;
> +	struct_group(body,
> +		u16 epl_len;
> +		u8 lpl_len;
> +		u8 chk_code;
> +		u8 resv1;
> +		u8 resv2;
> +		u8 payload[ETHTOOL_CMIS_CDB_LPL_MAX_PL_LENGTH];
> +	);
> +};
> +
> +#define CDB_F_COMPLETION_VALID		BIT(0)
> +#define CDB_F_STATUS_VALID		BIT(1)
> +
> +/**
> + * struct ethtool_cmis_cdb_cmd_args - CDB commands execution arguments
> + * @req: CDB command fields as described in the CMIS standard.
> + * @max_duration: Maximum duration time for command completion in msec.
> + * @read_write_len_ext: Allowable additional number of byte octets to the LPL
> + *			in a READ or a WRITE commands.
> + * @rpl_exp_len: Expected reply length in bytes.
> + * @flags: Validation flags for CDB commands.
> + */
> +struct ethtool_cmis_cdb_cmd_args {
> +	struct ethtool_cmis_cdb_request req;
> +	u16				max_duration;
> +	u8				read_write_len_ext;
> +	u8                              rpl_exp_len;
> +	u8				flags;
> +};

..

> +int ethtool_cmis_page_init(struct ethtool_module_eeprom *page_data,
> +			   u8 page, u32 offset, u32 length)
> +{
> +	page_data->page = page;
> +	page_data->offset = offset;
> +	page_data->length = length;
> +	page_data->i2c_address = ETHTOOL_CMIS_CDB_PAGE_I2C_ADDR;
> +	page_data->data = kmalloc(page_data->length, GFP_KERNEL);
> +	if (!page_data->data)
> +		return -ENOMEM;
> +
> +	return 0;
> +}

..

> +static int
> +__ethtool_cmis_cdb_execute_cmd(struct net_device *dev,
> +			       struct ethtool_module_eeprom *page_data,
> +			       u32 offset, u32 length, void *data)
> +{
> +	const struct ethtool_ops *ops = dev->ethtool_ops;
> +	struct netlink_ext_ack extack = {};
> +	int err;
> +
> +	page_data->offset = offset;
> +	page_data->length = length;
> +
> +	memset(page_data->data, 0, ETHTOOL_CMIS_CDB_LPL_MAX_PL_LENGTH);
> +	memcpy(page_data->data, data, page_data->length);
> +
> +	err = ops->set_module_eeprom_by_page(dev, page_data, &extack);
> +	if (err < 0) {
> +		if (extack._msg)
> +			netdev_err(dev, "%s\n", extack._msg);
> +	}
> +
> +	return err;
> +}

..

> +int ethtool_cmis_cdb_execute_cmd(struct net_device *dev,
> +				 struct ethtool_cmis_cdb_cmd_args *args)
> +{
> +	struct ethtool_module_eeprom page_data = {};
> +	u32 offset;
> +	int err;
> +
> +	args->req.chk_code =
> +		cmis_cdb_calc_checksum(&args->req, sizeof(args->req));
> +
> +	if (args->req.lpl_len > args->read_write_len_ext) {
> +		ethnl_module_fw_flash_ntf_err(dev,
> +					      "LPL length is longer than CDB read write length extension allows");
> +		return -EINVAL;
> +	}
> +
> +	err = ethtool_cmis_page_init(&page_data, ETHTOOL_CMIS_CDB_CMD_PAGE, 0,
> +				     ETHTOOL_CMIS_CDB_LPL_MAX_PL_LENGTH);

ETHTOOL_CMIS_CDB_LPL_MAX_PL_LENGTH is passed as the length argument
of ethtool_cmis_page_init, which will allocate that many
bytes for page_data->data.

> +	if (err < 0)
> +		return err;
> +
> +	/* According to the CMIS standard, there are two options to trigger the
> +	 * CDB commands. The default option is triggering the command by writing
> +	 * the CMDID bytes. Therefore, the command will be split to 2 calls:
> +	 * First, with everything except the CMDID field and then the CMDID
> +	 * field.
> +	 */
> +	offset = CMIS_CDB_CMD_ID_OFFSET +
> +		offsetof(struct ethtool_cmis_cdb_request, body);
> +	err = __ethtool_cmis_cdb_execute_cmd(dev, &page_data, offset,
> +					     sizeof(args->req.body),
> +					     &args->req.body);

Hi Danielle,

However, here sizeof(args->req.body) is passed as the length
argument of __ethtool_cmis_cdb_execute_cmd() which will:

1. Zero ETHTOOL_CMIS_CDB_LPL_MAX_PL_LENGTH bytes of page_data->data
2. Copy sizeof(args->req.body) bytes into page_data->data

args->req.body includes several fields, one of which is
ETHTOOL_CMIS_CDB_LPL_MAX_PL_LENGTH bytes long. So,
args->req.body > ETHTOOL_CMIS_CDB_LPL_MAX_PL_LENGTH
and it seems that step 2 above causes a buffer overrun.

Flagged by clang-17 W=1 build

 In file included from net/ethtool/cmis_cdb.c:3:
 In file included from ./include/linux/ethtool.h:16:
 In file included from ./include/linux/bitmap.h:12:
 In file included from ./include/linux/string.h:295:
 ./include/linux/fortify-string.h:579:4: error: call to '__write_overflow_field' declared with 'warning' attribute: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror,-Wattribute-warning]
   579 |                         __write_overflow_field(p_size_field, size);
       |                         ^
 ./include/linux/fortify-string.h:579:4: error: call to '__write_overflow_field' declared with 'warning' attribute: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror,-Wattribute-warning]
 ./include/linux/fortify-string.h:579:4: error: call to '__write_overflow_field' declared with 'warning' attribute: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror,-Wattribute-warning]


> +	if (err < 0)
> +		goto out;
> +
> +	offset = CMIS_CDB_CMD_ID_OFFSET +
> +		offsetof(struct ethtool_cmis_cdb_request, id);
> +	err = __ethtool_cmis_cdb_execute_cmd(dev, &page_data, offset,
> +					     sizeof(args->req.id),
> +					     &args->req.id);
> +	if (err < 0)
> +		goto out;
> +
> +	err = cmis_cdb_wait_for_completion(dev, args);
> +	if (err < 0)
> +		goto out;
> +
> +	err = cmis_cdb_wait_for_status(dev, args);
> +	if (err < 0)
> +		goto out;
> +
> +	err = cmis_cdb_process_reply(dev, &page_data, args);
> +
> +out:
> +	ethtool_cmis_page_fini(&page_data);
> +	return err;
> +}

..

