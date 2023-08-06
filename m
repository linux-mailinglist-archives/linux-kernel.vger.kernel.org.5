Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 229587715D1
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 17:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjHFPRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 11:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjHFPRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 11:17:34 -0400
X-Greylist: delayed 444 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Aug 2023 08:17:32 PDT
Received: from out-95.mta0.migadu.com (out-95.mta0.migadu.com [91.218.175.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C24114
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 08:17:32 -0700 (PDT)
Message-ID: <b8512626-2174-ff08-5b6d-4256d9e59093@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1691334606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F1RkAidIwdKp4fDPLFkoMthHjebqwooDc7ZtuGTIlE8=;
        b=xpnUy8p2tN3i9v9Z9V50+sI3vgEZPIN2wAC7f+x7DZ1OGiRN2RnpZa+Silwo7yUhitX/iY
        ++U1iHIYwlgMWWzPPecnj0lB7c/RG0rBVG0NkipMDcxjNNXBYpkwrtjvMojf6dT+S/MHdp
        EGvwTL0DIOFWva3OxcYeB+PcsJfx0jM=
Date:   Sun, 6 Aug 2023 23:09:36 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v6 1/2] soc: hisilicon: Support HCCS driver on Kunpeng SoC
Content-Language: en-US
To:     Huisong Li <lihuisong@huawei.com>, xuwei5@hisilicon.com,
        arnd@arndb.de, krzk@kernel.org, sudeep.holla@arm.com,
        rdunlap@infradead.org
Cc:     linux-kernel@vger.kernel.org, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org, wanghuiqiang@huawei.com,
        tanxiaofei@huawei.com, liuyonglong@huawei.com
References: <20230424073020.4039-1-lihuisong@huawei.com>
 <20230801024119.37215-1-lihuisong@huawei.com>
 <20230801024119.37215-2-lihuisong@huawei.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zenghui Yu <zenghui.yu@linux.dev>
In-Reply-To: <20230801024119.37215-2-lihuisong@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A few trivial comments inline.

On 2023/8/1 10:41, Huisong Li wrote:
> The Huawei Cache Coherence System (HCCS) is a multi-chip interconnection
> bus protocol. The performance of the application may be affected if some
> HCCS ports on platform are not in full lane status, have a large number
> of CRC errors and so on.
> 
> This driver provides the query interface of the health status and
> port information of HCCS on Kunpeng SoC.
> 
> Signed-off-by: Huisong Li <lihuisong@huawei.com>

[...]

> +static int hccs_query_all_port_info_on_platform(struct hccs_dev *hdev)
> +{
> +
> +	struct device *dev = hdev->dev;
> +	struct hccs_chip_info *chip;
> +	struct hccs_die_info *die;
> +	u8 i, j;
> +	int ret;
> +
> +	for (i = 0; i < hdev->chip_num; i++) {
> +		chip = &hdev->chips[i];
> +		for (j = 0; j < chip->die_num; j++) {
> +			die = &chip->dies[j];
> +			if (!die->port_num)
> +				continue;
> +
> +			die->ports = devm_kzalloc(dev,
> +				die->port_num * sizeof(struct hccs_port_info),
> +				GFP_KERNEL);
> +			if (!die->ports) {
> +				dev_err(dev, "allocate ports memory on chip%u/die%u failed.\n",
> +					i, die->die_id);
> +				return -ENOMEM;
> +			}
> +
> +			ret = hccs_get_all_port_info_on_die(hdev, die);
> +			if (ret) {
> +				dev_err(dev, "get die(%u) info on chip%u failed, ret = %d.\n",

"get *port* info failed"?

> +static int hccs_get_die_all_link_status(struct hccs_dev *hdev,
> +					const struct hccs_die_info *die,
> +					u8 *all_linked)
> +{
> +	struct hccs_die_comm_req_param *req_param;
> +	struct hccs_desc desc;
> +	int ret;
> +
> +	if (die->port_num == 0) {
> +		*all_linked = 1;
> +		return 0;
> +	}
> +
> +	hccs_init_req_desc(&desc);
> +	req_param = (struct hccs_die_comm_req_param *)desc.req.data;
> +	req_param->chip_id = die->chip->chip_id;
> +	req_param->die_id = die->die_id;
> +	ret = hccs_pcc_cmd_send(hdev, HCCS_GET_DIE_PORTS_LANE_STA, &desc);

Typo? Looks like we intend to send a HCCS_GET_DIE_PORTS_LINK_STA
command.

> +/*
> + * This value cannot be 255, otherwise the loop of the multi-BD communication
> + * case cannot end.
> + */
> +#define HCCS_DIE_MAX_PORT_ID	254

This looks weird. Isn't the "max port id" depends on your HW
implementation?

> +#define hccs_get_field(origin, mask, shift) \
> +	(((origin) & (mask)) >> (shift))
> +#define hccs_get_bit(origin, shift) \
> +	hccs_get_field((origin), (0x1UL << (shift)), (shift))

Unused macroes.

P.S., I'd personally prefer splitting this patch in 2 to ease other
reviewer's work:

- deal with the HCCS HW (chip/die/port) probing
- focus on the sysfs/query things

Zenghui
