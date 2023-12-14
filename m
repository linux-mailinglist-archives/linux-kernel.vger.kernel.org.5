Return-Path: <linux-kernel+bounces-105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4718813C48
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 22:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66891281D82
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 21:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64336AB85;
	Thu, 14 Dec 2023 21:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vnm7jFLS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DC054279;
	Thu, 14 Dec 2023 21:04:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A0D3C433C7;
	Thu, 14 Dec 2023 21:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702587879;
	bh=mtzD5oPpQFsNruIyS4e/UCD7JvY0HhXS/g0lTi+ReBI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vnm7jFLSwMHyXOgapWsPuU0LDcVMQ/LbCrrpJ39D9CzD0R+oQXEn19ygQBzaeRJV6
	 b06E4PJJrpkaq0oAMTanqhTekqVMP++fPlRHMg/fLaeiBBurK7t4is0vsKLLyGqJ/n
	 I8nXrrtjU6bmwwF0/L2OvF5nsVuI6fMQWFV7Qxb0SFJMR8qHl3EjYpW9wRfRk+A5KH
	 5eubmBm6oABnoed4GenKeWbiq97SXWLsiv362Np2At7Q5QDNHMpG/MsmXDf811toEM
	 X6Xqm5Q2nWbKY+CSJfQ1/xBoCgWQ1SWqduCSxa3DjnxlIZC9be4CEcDS2PmCXJKw3H
	 y+cKJrjvQI2gQ==
Date: Thu, 14 Dec 2023 21:04:34 +0000
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	shenjian15@huawei.com, wangjie125@huawei.com,
	liuyonglong@huawei.com, lanhao@huawei.com, wangpeiyang1@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 net-next 1/3] net: hns3: add command queue trace for
 hns3
Message-ID: <20231214210434.GU5817@kernel.org>
References: <20231214141135.613485-1-shaojijie@huawei.com>
 <20231214141135.613485-2-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214141135.613485-2-shaojijie@huawei.com>

On Thu, Dec 14, 2023 at 10:11:33PM +0800, Jijie Shao wrote:
> From: Hao Lan <lanhao@huawei.com>
> 
> Currently, the hns3 driver does not have the trace
> of the command queue. As a result, it is difficult to
> locate the communication between the driver and firmware.
> Therefore, the trace function of the command queue is
> added in this test case to facilitate the locating of
> communication problems between the driver and firmware.
> 
> Signed-off-by: Hao Lan <lanhao@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
>  .../hns3/hns3_common/hclge_comm_cmd.c         | 18 ++++
>  .../hns3/hns3_common/hclge_comm_cmd.h         | 14 ++-
>  .../hisilicon/hns3/hns3pf/hclge_main.c        | 45 +++++++++
>  .../hisilicon/hns3/hns3pf/hclge_trace.h       | 94 +++++++++++++++++++
>  .../hisilicon/hns3/hns3vf/hclgevf_main.c      | 40 ++++++++
>  .../hisilicon/hns3/hns3vf/hclgevf_trace.h     | 50 ++++++++++
>  6 files changed, 260 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.c b/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.c
> index d92ad6082d8e..424555e00e05 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.c
> @@ -470,10 +470,14 @@ static int hclge_comm_cmd_check_result(struct hclge_comm_hw *hw,
>  int hclge_comm_cmd_send(struct hclge_comm_hw *hw, struct hclge_desc *desc,
>  			int num)
>  {
> +	bool is_special = hclge_comm_is_special_opcode(desc->opcode);
>  	struct hclge_comm_cmq_ring *csq = &hw->cmq.csq;
>  	int ret;
>  	int ntc;

hclge_comm_is_special_opcode takes a u16 value as it's argument,
but the type of desc->opcode is __le16. So perhaps this should be
(completely untested!):

	struct hclge_comm_cmq_ring *csq = &hw->cmq.csq;
	bool is_special;
	...

	is_special = hclge_comm_is_special_opcode(le16_to_cpu(desc->opcode));

Flagged by Sparse.

>  
> +	if (hw->cmq.ops.trace_cmd_send)
> +		hw->cmq.ops.trace_cmd_send(hw, desc, num, is_special);
> +
>  	spin_lock_bh(&hw->cmq.csq.lock);
>  
>  	if (test_bit(HCLGE_COMM_STATE_CMD_DISABLE, &hw->comm_state)) {
> @@ -507,6 +511,9 @@ int hclge_comm_cmd_send(struct hclge_comm_hw *hw, struct hclge_desc *desc,
>  
>  	spin_unlock_bh(&hw->cmq.csq.lock);
>  
> +	if (hw->cmq.ops.trace_cmd_get)
> +		hw->cmq.ops.trace_cmd_get(hw, desc, num, is_special);
> +
>  	return ret;
>  }
>  
> @@ -584,6 +591,17 @@ int hclge_comm_cmd_queue_init(struct pci_dev *pdev, struct hclge_comm_hw *hw)
>  	return ret;
>  }
>  
> +void hclge_comm_cmd_init_ops(struct hclge_comm_hw *hw,
> +			     const struct hclge_comm_cmq_ops *ops)
> +{
> +	struct hclge_comm_cmq *cmdq = &hw->cmq;
> +
> +	if (ops) {
> +		cmdq->ops.trace_cmd_send = ops->trace_cmd_send;
> +		cmdq->ops.trace_cmd_get = ops->trace_cmd_get;
> +	}
> +}
> +
>  int hclge_comm_cmd_init(struct hnae3_ae_dev *ae_dev, struct hclge_comm_hw *hw,
>  			u32 *fw_version, bool is_pf,
>  			unsigned long reset_pending)
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.h b/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.h
> index 533c19d25e4f..387807b47d9a 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.h
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.h
> @@ -423,11 +423,22 @@ enum hclge_comm_cmd_status {
>  	HCLGE_COMM_ERR_CSQ_ERROR	= -3,
>  };
>  
> +struct hclge_comm_hw;
> +struct hclge_comm_cmq_ops {
> +	void (*trace_cmd_send)(struct hclge_comm_hw *hw,
> +			       struct hclge_desc *desc,
> +			       int num, bool is_special);
> +	void (*trace_cmd_get)(struct hclge_comm_hw *hw,
> +			      struct hclge_desc *desc,
> +			      int num, bool is_special);
> +};
> +
>  struct hclge_comm_cmq {
>  	struct hclge_comm_cmq_ring csq;
>  	struct hclge_comm_cmq_ring crq;
>  	u16 tx_timeout;
>  	enum hclge_comm_cmd_status last_status;
> +	struct hclge_comm_cmq_ops ops;
>  };
>  
>  struct hclge_comm_hw {
> @@ -474,5 +485,6 @@ int hclge_comm_cmd_queue_init(struct pci_dev *pdev, struct hclge_comm_hw *hw);
>  int hclge_comm_cmd_init(struct hnae3_ae_dev *ae_dev, struct hclge_comm_hw *hw,
>  			u32 *fw_version, bool is_pf,
>  			unsigned long reset_pending);
> -
> +void hclge_comm_cmd_init_ops(struct hclge_comm_hw *hw,
> +			     const struct hclge_comm_cmq_ops *ops);
>  #endif
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
> index 5ea9e59569ef..8c2562ae3c69 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
> @@ -27,6 +27,8 @@
>  #include "hclge_devlink.h"
>  #include "hclge_comm_cmd.h"
>  
> +#include "hclge_trace.h"
> +
>  #define HCLGE_NAME			"hclge"
>  
>  #define HCLGE_BUF_SIZE_UNIT	256U
> @@ -391,6 +393,48 @@ int hclge_cmd_send(struct hclge_hw *hw, struct hclge_desc *desc, int num)
>  	return hclge_comm_cmd_send(&hw->hw, desc, num);
>  }
>  
> +static void hclge_trace_cmd_send(struct hclge_comm_hw *hw, struct hclge_desc *desc,
> +				 int num, bool is_special)
> +{
> +	int i;
> +
> +	trace_hclge_pf_cmd_send(hw, desc, 0, num);
> +
> +	if (!is_special) {
> +		for (i = 1; i < num; i++)
> +			trace_hclge_pf_cmd_send(hw, &desc[i], i, num);
> +	} else {
> +		for (i = 1; i < num; i++)
> +			trace_hclge_pf_special_cmd_send(hw, (u32 *)&desc[i],
> +							i, num);
> +	}
> +}
> +
> +static void hclge_trace_cmd_get(struct hclge_comm_hw *hw, struct hclge_desc *desc,
> +				int num, bool is_special)
> +{
> +	int i;
> +
> +	if (!HCLGE_COMM_SEND_SYNC(le16_to_cpu(desc->flag)))
> +		return;
> +
> +	trace_hclge_pf_cmd_get(hw, desc, 0, num);
> +
> +	if (!is_special) {
> +		for (i = 1; i < num; i++)
> +			trace_hclge_pf_cmd_get(hw, &desc[i], i, num);
> +	} else {
> +		for (i = 1; i < num; i++)
> +			trace_hclge_pf_special_cmd_get(hw, (u32 *)&desc[i],
> +						       i, num);
> +	}
> +}
> +
> +static const struct hclge_comm_cmq_ops hclge_cmq_ops = {
> +	.trace_cmd_send = hclge_trace_cmd_send,
> +	.trace_cmd_get = hclge_trace_cmd_get,
> +};
> +
>  static int hclge_mac_update_stats_defective(struct hclge_dev *hdev)
>  {
>  #define HCLGE_MAC_CMD_NUM 21
> @@ -11616,6 +11660,7 @@ static int hclge_init_ae_dev(struct hnae3_ae_dev *ae_dev)
>  		goto err_devlink_uninit;
>  
>  	/* Firmware command initialize */
> +	hclge_comm_cmd_init_ops(&hdev->hw.hw, &hclge_cmq_ops);
>  	ret = hclge_comm_cmd_init(hdev->ae_dev, &hdev->hw.hw, &hdev->fw_version,
>  				  true, hdev->reset_pending);
>  	if (ret)
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_trace.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_trace.h
> index 8510b88d4982..116ac3a5ffc5 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_trace.h
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_trace.h
> @@ -10,6 +10,7 @@
>  
>  #include <linux/tracepoint.h>
>  
> +#define PF_DESC_LEN	(sizeof(struct hclge_desc) / sizeof(u32))
>  #define PF_GET_MBX_LEN	(sizeof(struct hclge_mbx_vf_to_pf_cmd) / sizeof(u32))
>  #define PF_SEND_MBX_LEN	(sizeof(struct hclge_mbx_pf_to_vf_cmd) / sizeof(u32))
>  
> @@ -77,6 +78,99 @@ TRACE_EVENT(hclge_pf_mbx_send,
>  	)
>  );
>  
> +DECLARE_EVENT_CLASS(hclge_pf_cmd_template,
> +		    TP_PROTO(struct hclge_comm_hw *hw,
> +			     struct hclge_desc *desc,
> +			     int index,
> +			     int num),
> +		    TP_ARGS(hw, desc, index, num),
> +
> +		    TP_STRUCT__entry(__field(u16, opcode)
> +			__field(u16, flag)
> +			__field(u16, retval)
> +			__field(u16, rsv)
> +			__field(int, index)
> +			__field(int, num)
> +			__string(pciname, pci_name(hw->cmq.csq.pdev))
> +			__array(u32, data, HCLGE_DESC_DATA_LEN)),
> +
> +		    TP_fast_assign(int i;
> +			__entry->opcode = le16_to_cpu(desc->opcode);
> +			__entry->flag = le16_to_cpu(desc->flag);
> +			__entry->retval = le16_to_cpu(desc->retval);
> +			__entry->rsv = le16_to_cpu(desc->rsv);
> +			__entry->index = index;
> +			__entry->num = num;
> +			__assign_str(pciname, pci_name(hw->cmq.csq.pdev));
> +			for (i = 0; i < HCLGE_DESC_DATA_LEN; i++)
> +				__entry->data[i] = le32_to_cpu(desc->data[i]);),
> +
> +		    TP_printk("%s opcode:0x%04x %d-%d flag:0x%04x retval:0x%04x rsv:0x%04x data:%s",
> +			      __get_str(pciname), __entry->opcode,
> +			      __entry->index, __entry->num,
> +			      __entry->flag, __entry->retval, __entry->rsv,
> +			      __print_array(__entry->data,
> +					    HCLGE_DESC_DATA_LEN, sizeof(u32)))
> +);
> +
> +DEFINE_EVENT(hclge_pf_cmd_template, hclge_pf_cmd_send,
> +	     TP_PROTO(struct hclge_comm_hw *hw,
> +		      struct hclge_desc *desc,
> +		      int index,
> +		      int num),
> +	     TP_ARGS(hw, desc, index, num)
> +);
> +
> +DEFINE_EVENT(hclge_pf_cmd_template, hclge_pf_cmd_get,
> +	     TP_PROTO(struct hclge_comm_hw *hw,
> +		      struct hclge_desc *desc,
> +		      int index,
> +		      int num),
> +	     TP_ARGS(hw, desc, index, num)
> +);
> +
> +DECLARE_EVENT_CLASS(hclge_pf_special_cmd_template,
> +		    TP_PROTO(struct hclge_comm_hw *hw,
> +			     u32 *data,
> +			     int index,
> +			     int num),
> +		    TP_ARGS(hw, data, index, num),
> +
> +		    TP_STRUCT__entry(__field(int, index)
> +			__field(int, num)
> +			__string(pciname, pci_name(hw->cmq.csq.pdev))
> +			__array(u32, data, PF_DESC_LEN)),
> +
> +		    TP_fast_assign(int i;
> +			__entry->index = index;
> +			__entry->num = num;
> +			__assign_str(pciname, pci_name(hw->cmq.csq.pdev));
> +			for (i = 0; i < PF_DESC_LEN; i++)
> +				__entry->data[i] = le32_to_cpu(data[i]);
> +		),
> +
> +		    TP_printk("%s %d-%d data:%s",
> +			      __get_str(pciname),
> +			      __entry->index, __entry->num,
> +			      __print_array(__entry->data,
> +					    PF_DESC_LEN, sizeof(u32)))
> +);
> +
> +DEFINE_EVENT(hclge_pf_special_cmd_template, hclge_pf_special_cmd_send,
> +	     TP_PROTO(struct hclge_comm_hw *hw,
> +		      u32 *desc,
> +		      int index,
> +		      int num),
> +	     TP_ARGS(hw, desc, index, num));
> +
> +DEFINE_EVENT(hclge_pf_special_cmd_template, hclge_pf_special_cmd_get,
> +	     TP_PROTO(struct hclge_comm_hw *hw,
> +		      u32 *desc,
> +		      int index,
> +		      int num),
> +	     TP_ARGS(hw, desc, index, num)
> +);
> +
>  #endif /* _HCLGE_TRACE_H_ */
>  
>  /* This must be outside ifdef _HCLGE_TRACE_H */
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
> index 0aa9beefd1c7..ecc092555362 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
> @@ -11,6 +11,7 @@
>  #include "hnae3.h"
>  #include "hclgevf_devlink.h"
>  #include "hclge_comm_rss.h"
> +#include "hclgevf_trace.h"
>  
>  #define HCLGEVF_NAME	"hclgevf"
>  
> @@ -47,6 +48,42 @@ int hclgevf_cmd_send(struct hclgevf_hw *hw, struct hclge_desc *desc, int num)
>  	return hclge_comm_cmd_send(&hw->hw, desc, num);
>  }
>  
> +static void hclgevf_trace_cmd_send(struct hclge_comm_hw *hw, struct hclge_desc *desc,
> +				   int num, bool is_special)
> +{
> +	int i;
> +
> +	trace_hclge_vf_cmd_send(hw, desc, 0, num);
> +
> +	if (is_special)
> +		return;
> +
> +	for (i = 1; i < num; i++)
> +		trace_hclge_vf_cmd_send(hw, &desc[i], i, num);
> +}
> +
> +static void hclgevf_trace_cmd_get(struct hclge_comm_hw *hw, struct hclge_desc *desc,
> +				  int num, bool is_special)
> +{
> +	int i;
> +
> +	if (!HCLGE_COMM_SEND_SYNC(le16_to_cpu(desc->flag)))
> +		return;
> +
> +	trace_hclge_vf_cmd_get(hw, desc, 0, num);
> +
> +	if (is_special)
> +		return;
> +
> +	for (i = 1; i < num; i++)
> +		trace_hclge_vf_cmd_get(hw, &desc[i], i, num);
> +}
> +
> +static const struct hclge_comm_cmq_ops hclgevf_cmq_ops = {
> +	.trace_cmd_send = hclgevf_trace_cmd_send,
> +	.trace_cmd_get = hclgevf_trace_cmd_get,
> +};
> +
>  void hclgevf_arq_init(struct hclgevf_dev *hdev)
>  {
>  	struct hclge_comm_cmq *cmdq = &hdev->hw.hw.cmq;
> @@ -2796,6 +2833,7 @@ static int hclgevf_reset_hdev(struct hclgevf_dev *hdev)
>  	}
>  
>  	hclgevf_arq_init(hdev);
> +
>  	ret = hclge_comm_cmd_init(hdev->ae_dev, &hdev->hw.hw,
>  				  &hdev->fw_version, false,
>  				  hdev->reset_pending);
> @@ -2854,6 +2892,8 @@ static int hclgevf_init_hdev(struct hclgevf_dev *hdev)
>  		goto err_cmd_queue_init;
>  
>  	hclgevf_arq_init(hdev);
> +
> +	hclge_comm_cmd_init_ops(&hdev->hw.hw, &hclgevf_cmq_ops);
>  	ret = hclge_comm_cmd_init(hdev->ae_dev, &hdev->hw.hw,
>  				  &hdev->fw_version, false,
>  				  hdev->reset_pending);
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_trace.h b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_trace.h
> index 5d4895bb57a1..82263cb5e47b 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_trace.h
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_trace.h
> @@ -77,6 +77,56 @@ TRACE_EVENT(hclge_vf_mbx_send,
>  	)
>  );
>  
> +DECLARE_EVENT_CLASS(hclge_vf_cmd_template,
> +		    TP_PROTO(struct hclge_comm_hw *hw,
> +			     struct hclge_desc *desc,
> +			     int index,
> +			     int num),
> +
> +		    TP_ARGS(hw, desc, index, num),
> +
> +		    TP_STRUCT__entry(__field(u16, opcode)
> +			__field(u16, flag)
> +			__field(u16, retval)
> +			__field(u16, rsv)
> +			__field(int, index)
> +			__field(int, num)
> +			__string(pciname, pci_name(hw->cmq.csq.pdev))
> +			__array(u32, data, HCLGE_DESC_DATA_LEN)),
> +
> +		    TP_fast_assign(int i;
> +			__entry->opcode = le16_to_cpu(desc->opcode);
> +			__entry->flag = le16_to_cpu(desc->flag);
> +			__entry->retval = le16_to_cpu(desc->retval);
> +			__entry->rsv = le16_to_cpu(desc->rsv);
> +			__entry->index = index;
> +			__entry->num = num;
> +			__assign_str(pciname, pci_name(hw->cmq.csq.pdev));
> +			for (i = 0; i < HCLGE_DESC_DATA_LEN; i++)
> +				__entry->data[i] = le32_to_cpu(desc->data[i]);),
> +
> +		    TP_printk("%s opcode:0x%04x %d-%d flag:0x%04x retval:0x%04x rsv:0x%04x data:%s",
> +			      __get_str(pciname), __entry->opcode,
> +			      __entry->index, __entry->num,
> +			      __entry->flag, __entry->retval, __entry->rsv,
> +			      __print_array(__entry->data,
> +					    HCLGE_DESC_DATA_LEN, sizeof(u32)))
> +);
> +
> +DEFINE_EVENT(hclge_vf_cmd_template, hclge_vf_cmd_send,
> +	     TP_PROTO(struct hclge_comm_hw *hw,
> +		      struct hclge_desc *desc,
> +		      int index,
> +		      int num),
> +	     TP_ARGS(hw, desc, index, num));
> +
> +DEFINE_EVENT(hclge_vf_cmd_template, hclge_vf_cmd_get,
> +	     TP_PROTO(struct hclge_comm_hw *hw,
> +		      struct hclge_desc *desc,
> +		      int index,
> +		      int num),
> +	     TP_ARGS(hw, desc, index, num));
> +
>  #endif /* _HCLGEVF_TRACE_H_ */
>  
>  /* This must be outside ifdef _HCLGEVF_TRACE_H */
> -- 
> 2.30.0
> 

