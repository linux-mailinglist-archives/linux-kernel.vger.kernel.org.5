Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71548770DD6
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 06:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjHEE7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 00:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHEE7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 00:59:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F554EDA;
        Fri,  4 Aug 2023 21:59:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D4B460A50;
        Sat,  5 Aug 2023 04:59:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F231C433C8;
        Sat,  5 Aug 2023 04:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691211551;
        bh=Ut8y/AibahdfvB8nD+bIrbVsgB6ZGPhgo3NGHcrJNg4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U9IWZzxq2BUwpkpNZ4gVvI+A3TQWYK6zwBqoo4tmoI8ZxFOSQi79JjAvcn7kd2nb4
         HrGv6bEMau7sdeX9mg11v6341CDohSXyVkBdSBrrIUqvpSL6a4azJ2JU2ttyLHgo7q
         hCHxR5X4Y2hQ4m4lizcI0uVkQjdrfPbWz1TvzPp6mtvqozjP9ifefNZ/HKRYhkVxmK
         5CD+jTs90aIxjUUvNs3wA51cWmcB4+Ug2Pkg2N2qWq/OmyzJLtVNlv3LBAF4qHBA+L
         74WDeMFgoIsUgS30cD/6L8p/KyRY0xoXAlT+fsBJu1OvitusWgqjz4X2O0/7UThNkZ
         RFG9GmuLBmnBg==
Date:   Fri, 4 Aug 2023 22:02:09 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Will Deacon <will@kernel.org>, Andy Gross <agross@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v14 07/25] gunyah: rsc_mgr: Add resource manager RPC core
Message-ID: <twf5ygdy7gphbevbjngm5iyfslqghljhcbt7qraxsvqapwonww@no6mvahxsgoj>
References: <20230613172054.3959700-1-quic_eberman@quicinc.com>
 <20230613172054.3959700-8-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613172054.3959700-8-quic_eberman@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 10:20:35AM -0700, Elliot Berman wrote:
> The resource manager is a special virtual machine which is always
> running on a Gunyah system. It provides APIs for creating and destroying
> VMs, secure memory management, sharing/lending of memory between VMs,
> and setup of inter-VM communication. Calls to the resource manager are
> made via message queues.
> 
> This patch implements the basic probing and RPC mechanism to make those
> API calls. Request/response calls can be made with gh_rm_call.
> Drivers can also register to notifications pushed by RM via
> gh_rm_register_notifier
> 
> Specific API calls that resource manager supports will be implemented in
> subsequent patches.
> 
> Reviewed-by: Alex Elder <elder@linaro.org>
> Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>  drivers/virt/Makefile          |   1 +
>  drivers/virt/gunyah/Makefile   |   4 +
>  drivers/virt/gunyah/rsc_mgr.c  | 700 +++++++++++++++++++++++++++++++++
>  drivers/virt/gunyah/rsc_mgr.h  |  16 +
>  include/linux/gunyah_rsc_mgr.h |  21 +
>  5 files changed, 742 insertions(+)
>  create mode 100644 drivers/virt/gunyah/Makefile
>  create mode 100644 drivers/virt/gunyah/rsc_mgr.c
>  create mode 100644 drivers/virt/gunyah/rsc_mgr.h
>  create mode 100644 include/linux/gunyah_rsc_mgr.h
> 
> diff --git a/drivers/virt/Makefile b/drivers/virt/Makefile
> index e9aa6fc96fab7..a5817e2d7d718 100644
> --- a/drivers/virt/Makefile
> +++ b/drivers/virt/Makefile
> @@ -12,3 +12,4 @@ obj-$(CONFIG_ACRN_HSM)		+= acrn/
>  obj-$(CONFIG_EFI_SECRET)	+= coco/efi_secret/
>  obj-$(CONFIG_SEV_GUEST)		+= coco/sev-guest/
>  obj-$(CONFIG_INTEL_TDX_GUEST)	+= coco/tdx-guest/
> +obj-y				+= gunyah/
> diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
> new file mode 100644
> index 0000000000000..0f5aec8346988
> --- /dev/null
> +++ b/drivers/virt/gunyah/Makefile
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +gunyah-y += rsc_mgr.o
> +obj-$(CONFIG_GUNYAH) += gunyah.o
> diff --git a/drivers/virt/gunyah/rsc_mgr.c b/drivers/virt/gunyah/rsc_mgr.c
> new file mode 100644
> index 0000000000000..04c8e131d259f
> --- /dev/null
> +++ b/drivers/virt/gunyah/rsc_mgr.c
> @@ -0,0 +1,700 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/of.h>
> +#include <linux/slab.h>
> +#include <linux/mutex.h>
> +#include <linux/sched.h>
> +#include <linux/gunyah.h>
> +#include <linux/module.h>
> +#include <linux/of_irq.h>
> +#include <linux/notifier.h>
> +#include <linux/workqueue.h>
> +#include <linux/completion.h>
> +#include <linux/gunyah_rsc_mgr.h>
> +#include <linux/platform_device.h>
> +
> +#include "rsc_mgr.h"
> +
> +#define RM_RPC_API_VERSION_MASK		GENMASK(3, 0)
> +#define RM_RPC_HEADER_WORDS_MASK	GENMASK(7, 4)
> +#define RM_RPC_API_VERSION		FIELD_PREP(RM_RPC_API_VERSION_MASK, 1)
> +#define RM_RPC_HEADER_WORDS		FIELD_PREP(RM_RPC_HEADER_WORDS_MASK, \
> +						(sizeof(struct gh_rm_rpc_hdr) / sizeof(u32)))
> +#define RM_RPC_API			(RM_RPC_API_VERSION | RM_RPC_HEADER_WORDS)
> +
> +#define RM_RPC_TYPE_CONTINUATION	0x0
> +#define RM_RPC_TYPE_REQUEST		0x1
> +#define RM_RPC_TYPE_REPLY		0x2
> +#define RM_RPC_TYPE_NOTIF		0x3
> +#define RM_RPC_TYPE_MASK		GENMASK(1, 0)
> +
> +#define GH_RM_MAX_NUM_FRAGMENTS		62
> +#define RM_RPC_FRAGMENTS_MASK		GENMASK(7, 2)
> +
> +struct gh_rm_rpc_hdr {
> +	u8 api;
> +	u8 type;
> +	__le16 seq;
> +	__le32 msg_id;
> +} __packed;
> +
> +struct gh_rm_rpc_reply_hdr {
> +	struct gh_rm_rpc_hdr hdr;
> +	__le32 err_code; /* GH_RM_ERROR_* */
> +} __packed;
> +
> +#define GH_RM_MAX_MSG_SIZE	(GH_MSGQ_MAX_MSG_SIZE - sizeof(struct gh_rm_rpc_hdr))
> +
> +/* RM Error codes */
> +enum gh_rm_error {
> +	GH_RM_ERROR_OK			= 0x0,
> +	GH_RM_ERROR_UNIMPLEMENTED	= 0xFFFFFFFF,
> +	GH_RM_ERROR_NOMEM		= 0x1,
> +	GH_RM_ERROR_NORESOURCE		= 0x2,
> +	GH_RM_ERROR_DENIED		= 0x3,
> +	GH_RM_ERROR_INVALID		= 0x4,
> +	GH_RM_ERROR_BUSY		= 0x5,
> +	GH_RM_ERROR_ARGUMENT_INVALID	= 0x6,
> +	GH_RM_ERROR_HANDLE_INVALID	= 0x7,
> +	GH_RM_ERROR_VALIDATE_FAILED	= 0x8,
> +	GH_RM_ERROR_MAP_FAILED		= 0x9,
> +	GH_RM_ERROR_MEM_INVALID		= 0xA,
> +	GH_RM_ERROR_MEM_INUSE		= 0xB,
> +	GH_RM_ERROR_MEM_RELEASED	= 0xC,
> +	GH_RM_ERROR_VMID_INVALID	= 0xD,
> +	GH_RM_ERROR_LOOKUP_FAILED	= 0xE,
> +	GH_RM_ERROR_IRQ_INVALID		= 0xF,
> +	GH_RM_ERROR_IRQ_INUSE		= 0x10,
> +	GH_RM_ERROR_IRQ_RELEASED	= 0x11,
> +};
> +
> +/**
> + * struct gh_rm_connection - Represents a complete message from resource manager
> + * @payload: Combined payload of all the fragments (msg headers stripped off).
> + * @size: Size of the payload received so far.
> + * @msg_id: Message ID from the header.
> + * @type: RM_RPC_TYPE_REPLY or RM_RPC_TYPE_NOTIF.
> + * @num_fragments: total number of fragments expected to be received.
> + * @fragments_received: fragments received so far.
> + * @reply: Fields used for request/reply sequences
> + * @notification: Fields used for notifiations
> + */
> +struct gh_rm_connection {

Is there a good reason why this is called a connection, when it's
actually a message (specifically a response or notification)?

> +	void *payload;
> +	size_t size;
> +	__le32 msg_id;

Everything else in this struct is native endian, I don't think you loose
much from keeping this native and moving your
cpu_to_le32()/le32_to_cpu() calls around the implementation.

> +	u8 type;
> +
> +	u8 num_fragments;
> +	u8 fragments_received;
> +
> +	union {
> +		/**
> +		 * @ret: Linux return code, there was an error processing connection
> +		 * @seq: Sequence ID for the main message.
> +		 * @rm_error: For request/reply sequences with standard replies
> +		 * @seq_done: Signals caller that the RM reply has been received
> +		 */
> +		struct {
> +			int ret;
> +			u16 seq;
> +			enum gh_rm_error rm_error;
> +			struct completion seq_done;
> +		} reply;
> +
> +		/**
> +		 * @rm: Pointer to the RM that launched the connection
> +		 * @work: Triggered when all fragments of a notification received
> +		 */
> +		struct {
> +			struct gh_rm *rm;
> +			struct work_struct work;
> +		} notification;
> +	};
> +};
> +
> +/**
> + * struct gh_rm - private data for communicating w/Gunyah resource manager
> + * @dev: pointer to RM platform device
> + * @tx_ghrsc: message queue resource to TX to RM
> + * @rx_ghrsc: message queue resource to RX from RM
> + * @msgq: mailbox instance of TX/RX resources above
> + * @msgq_client: mailbox client of above msgq
> + * @active_rx_connection: ongoing gh_rm_connection for which we're receiving fragments
> + * @last_tx_ret: return value of last mailbox tx
> + * @call_xarray: xarray to allocate & lookup sequence IDs for Request/Response flows
> + * @next_seq: next ID to allocate (for xa_alloc_cyclic)
> + * @cache: cache for allocating Tx messages
> + * @send_lock: synchronization to allow only one request to be sent at a time
> + * @nh: notifier chain for clients interested in RM notification messages
> + */
> +struct gh_rm {
> +	struct device *dev;
> +	struct gh_resource tx_ghrsc;
> +	struct gh_resource rx_ghrsc;
> +	struct gh_msgq msgq;
> +	struct mbox_client msgq_client;
> +	struct gh_rm_connection *active_rx_connection;
> +	int last_tx_ret;
> +
> +	struct xarray call_xarray;
> +	u32 next_seq;
> +
> +	struct kmem_cache *cache;
> +	struct mutex send_lock;
> +	struct blocking_notifier_head nh;
> +};
> +
> +/**
> + * gh_rm_error_remap() - Remap Gunyah resource manager errors into a Linux error code
> + * @rm_error: "Standard" return value from Gunyah resource manager
> + */
> +static inline int gh_rm_error_remap(enum gh_rm_error rm_error)
> +{
> +	switch (rm_error) {
> +	case GH_RM_ERROR_OK:
> +		return 0;
> +	case GH_RM_ERROR_UNIMPLEMENTED:
> +		return -EOPNOTSUPP;
> +	case GH_RM_ERROR_NOMEM:
> +		return -ENOMEM;
> +	case GH_RM_ERROR_NORESOURCE:
> +		return -ENODEV;
> +	case GH_RM_ERROR_DENIED:
> +		return -EPERM;
> +	case GH_RM_ERROR_BUSY:
> +		return -EBUSY;
> +	case GH_RM_ERROR_INVALID:
> +	case GH_RM_ERROR_ARGUMENT_INVALID:
> +	case GH_RM_ERROR_HANDLE_INVALID:
> +	case GH_RM_ERROR_VALIDATE_FAILED:
> +	case GH_RM_ERROR_MAP_FAILED:
> +	case GH_RM_ERROR_MEM_INVALID:
> +	case GH_RM_ERROR_MEM_INUSE:
> +	case GH_RM_ERROR_MEM_RELEASED:
> +	case GH_RM_ERROR_VMID_INVALID:
> +	case GH_RM_ERROR_LOOKUP_FAILED:
> +	case GH_RM_ERROR_IRQ_INVALID:
> +	case GH_RM_ERROR_IRQ_INUSE:
> +	case GH_RM_ERROR_IRQ_RELEASED:
> +		return -EINVAL;
> +	default:
> +		return -EBADMSG;
> +	}
> +}
> +
> +static int gh_rm_init_connection_payload(struct gh_rm_connection *connection, void *msg,
> +					size_t hdr_size, size_t msg_size)
> +{
> +	size_t max_buf_size, payload_size;
> +	struct gh_rm_rpc_hdr *hdr = msg;
> +
> +	if (msg_size < hdr_size)
> +		return -EINVAL;
> +
> +	payload_size = msg_size - hdr_size;
> +
> +	connection->num_fragments = FIELD_GET(RM_RPC_FRAGMENTS_MASK, hdr->type);
> +	connection->fragments_received = 0;
> +
> +	/* There's not going to be any payload, no need to allocate buffer. */
> +	if (!payload_size && !connection->num_fragments)
> +		return 0;
> +
> +	if (connection->num_fragments > GH_RM_MAX_NUM_FRAGMENTS)
> +		return -EINVAL;
> +
> +	max_buf_size = payload_size + (connection->num_fragments * GH_RM_MAX_MSG_SIZE);
> +
> +	connection->payload = kzalloc(max_buf_size, GFP_KERNEL);
> +	if (!connection->payload)
> +		return -ENOMEM;
> +
> +	memcpy(connection->payload, msg + hdr_size, payload_size);
> +	connection->size = payload_size;
> +	return 0;
> +}
> +
> +static void gh_rm_abort_connection(struct gh_rm *rm)
> +{
> +	switch (rm->active_rx_connection->type) {
> +	case RM_RPC_TYPE_REPLY:
> +		rm->active_rx_connection->reply.ret = -EIO;
> +		complete(&rm->active_rx_connection->reply.seq_done);
> +		break;
> +	case RM_RPC_TYPE_NOTIF:
> +		fallthrough;

Don't you need to cancel the work here as well?

> +	default:
> +		kfree(rm->active_rx_connection->payload);
> +		kfree(rm->active_rx_connection);
> +	}
> +
> +	rm->active_rx_connection = NULL;
> +}
> +
> +static void gh_rm_notif_work(struct work_struct *work)
> +{
> +	struct gh_rm_connection *connection = container_of(work, struct gh_rm_connection,
> +								notification.work);
> +	struct gh_rm *rm = connection->notification.rm;
> +
> +	blocking_notifier_call_chain(&rm->nh, le32_to_cpu(connection->msg_id), connection->payload);
> +
> +	put_device(rm->dev);
> +	kfree(connection->payload);
> +	kfree(connection);
> +}
> +
> +static void gh_rm_process_notif(struct gh_rm *rm, void *msg, size_t msg_size)
> +{
> +	struct gh_rm_connection *connection;
> +	struct gh_rm_rpc_hdr *hdr = msg;
> +	int ret;
> +
> +	if (rm->active_rx_connection)
> +		gh_rm_abort_connection(rm);

So every notification or reply is always expected to be sent in full, or
it should be thrown away?

I do find this logic a little bit odd, can you confirm that this is
defined by the hypervisor?

> +
> +	connection = kzalloc(sizeof(*connection), GFP_KERNEL);
> +	if (!connection)
> +		return;
> +
> +	connection->type = RM_RPC_TYPE_NOTIF;
> +	connection->msg_id = hdr->msg_id;
> +
> +	get_device(rm->dev);
> +	connection->notification.rm = rm;
> +	INIT_WORK(&connection->notification.work, gh_rm_notif_work);

I tend to dislike work in allocated objects, in particularly when they
are scheduled on the global work queues...

I'd prefer a list of outstanding notifications associated with the rm
and a worker that traverses that list. That saves you from carrying the
rm back-pointer in the "connection" and you don't need to refcount the
rm->dev.

> +
> +	ret = gh_rm_init_connection_payload(connection, msg, sizeof(*hdr), msg_size);
> +	if (ret) {
> +		dev_err(rm->dev, "Failed to initialize connection for notification: %d\n", ret);
> +		put_device(rm->dev);
> +		kfree(connection);
> +		return;
> +	}
> +
> +	rm->active_rx_connection = connection;
> +}
> +
> +static void gh_rm_process_reply(struct gh_rm *rm, void *msg, size_t msg_size)
> +{
> +	struct gh_rm_rpc_reply_hdr *reply_hdr = msg;
> +	struct gh_rm_connection *connection;
> +	u16 seq_id;
> +
> +	seq_id = le16_to_cpu(reply_hdr->hdr.seq);
> +	connection = xa_load(&rm->call_xarray, seq_id);
> +
> +	if (!connection || connection->msg_id != reply_hdr->hdr.msg_id)

Wouldn't it be bad if a response is received with the wrong msg_id?
Please confirm that this should be silently ignored.

> +		return;
> +
> +	if (rm->active_rx_connection)
> +		gh_rm_abort_connection(rm);
> +
> +	if (gh_rm_init_connection_payload(connection, msg, sizeof(*reply_hdr), msg_size)) {
> +		dev_err(rm->dev, "Failed to alloc connection buffer for sequence %d\n", seq_id);
> +		/* Send connection complete and error the client. */
> +		connection->reply.ret = -ENOMEM;
> +		complete(&connection->reply.seq_done);
> +		return;
> +	}
> +
> +	connection->reply.rm_error = le32_to_cpu(reply_hdr->err_code);
> +	rm->active_rx_connection = connection;
> +}
> +
> +static void gh_rm_process_cont(struct gh_rm *rm, struct gh_rm_connection *connection,
> +				void *msg, size_t msg_size)
> +{
> +	struct gh_rm_rpc_hdr *hdr = msg;
> +	size_t payload_size = msg_size - sizeof(*hdr);
> +
> +	if (!rm->active_rx_connection)

Perhaps reasonable to be consistent and complain if the hypervisor gives
you a continuation when you have no active response? Seems like this
would result in a silent hang...

> +		return;
> +
> +	/*
> +	 * hdr->fragments and hdr->msg_id preserves the value from first reply
> +	 * or notif message. To detect mishandling, check it's still intact.
> +	 */
> +	if (connection->msg_id != hdr->msg_id ||
> +		connection->num_fragments != FIELD_GET(RM_RPC_FRAGMENTS_MASK, hdr->type)) {

When breaking an expression, align all lines under each other. Here it
looks like connection->num_fragments.. is part of the conditional block,
rather than the expression.

> +		gh_rm_abort_connection(rm);
> +		return;
> +	}
> +
> +	memcpy(connection->payload + connection->size, msg + sizeof(*hdr), payload_size);
> +	connection->size += payload_size;
> +	connection->fragments_received++;
> +}
> +
> +static void gh_rm_try_complete_connection(struct gh_rm *rm)
> +{
> +	struct gh_rm_connection *connection = rm->active_rx_connection;
> +
> +	if (!connection || connection->fragments_received != connection->num_fragments)
> +		return;
> +
> +	switch (connection->type) {
> +	case RM_RPC_TYPE_REPLY:
> +		complete(&connection->reply.seq_done);
> +		break;
> +	case RM_RPC_TYPE_NOTIF:
> +		schedule_work(&connection->notification.work);
> +		break;
> +	default:
> +		dev_err_ratelimited(rm->dev, "Invalid message type (%u) received\n",
> +					connection->type);
> +		gh_rm_abort_connection(rm);
> +		break;
> +	}
> +
> +	rm->active_rx_connection = NULL;
> +}
> +
> +static void gh_rm_msgq_rx_data(struct mbox_client *cl, void *mssg)
> +{
> +	struct gh_rm *rm = container_of(cl, struct gh_rm, msgq_client);
> +	struct gh_msgq_rx_data *rx_data = mssg;
> +	size_t msg_size = rx_data->length;
> +	void *msg = rx_data->data;
> +	struct gh_rm_rpc_hdr *hdr;
> +
> +	if (msg_size < sizeof(*hdr) || msg_size > GH_MSGQ_MAX_MSG_SIZE)
> +		return;
> +
> +	hdr = msg;
> +	if (hdr->api != RM_RPC_API) {
> +		dev_err(rm->dev, "Unknown RM RPC API version: %x\n", hdr->api);
> +		return;
> +	}
> +
> +	switch (FIELD_GET(RM_RPC_TYPE_MASK, hdr->type)) {
> +	case RM_RPC_TYPE_NOTIF:
> +		gh_rm_process_notif(rm, msg, msg_size);
> +		break;
> +	case RM_RPC_TYPE_REPLY:
> +		gh_rm_process_reply(rm, msg, msg_size);
> +		break;
> +	case RM_RPC_TYPE_CONTINUATION:
> +		gh_rm_process_cont(rm, rm->active_rx_connection, msg, msg_size);
> +		break;
> +	default:
> +		dev_err(rm->dev, "Invalid message type (%lu) received\n",
> +			FIELD_GET(RM_RPC_TYPE_MASK, hdr->type));
> +		return;
> +	}
> +
> +	gh_rm_try_complete_connection(rm);

I stared at this logic for quite a while, I think it would be clearer if
you moved the "now check if we did get all the data and if so handle it"
to each f the process functions.

> +}
> +
> +static void gh_rm_msgq_tx_done(struct mbox_client *cl, void *mssg, int r)
> +{
> +	struct gh_rm *rm = container_of(cl, struct gh_rm, msgq_client);
> +
> +	kmem_cache_free(rm->cache, mssg);
> +	rm->last_tx_ret = r;
> +}
> +
> +static int gh_rm_send_request(struct gh_rm *rm, u32 message_id,
> +			      const void *req_buf, size_t req_buf_size,
> +			      struct gh_rm_connection *connection)
> +{
> +	size_t buf_size_remaining = req_buf_size;
> +	const void *req_buf_curr = req_buf;
> +	struct gh_msgq_tx_data *msg;
> +	struct gh_rm_rpc_hdr *hdr, hdr_template;
> +	u32 cont_fragments = 0;
> +	size_t payload_size;
> +	void *payload;
> +	int ret;
> +
> +	if (req_buf_size > GH_RM_MAX_NUM_FRAGMENTS * GH_RM_MAX_MSG_SIZE) {
> +		dev_warn(rm->dev, "Limit (%lu bytes) exceeded for the maximum message size: %lu\n",
> +			GH_RM_MAX_NUM_FRAGMENTS * GH_RM_MAX_MSG_SIZE, req_buf_size);
> +		dump_stack();
> +		return -E2BIG;
> +	}
> +
> +	if (req_buf_size)
> +		cont_fragments = (req_buf_size - 1) / GH_RM_MAX_MSG_SIZE;
> +
> +	hdr_template.api = RM_RPC_API;
> +	hdr_template.type = FIELD_PREP(RM_RPC_TYPE_MASK, RM_RPC_TYPE_REQUEST) |
> +				FIELD_PREP(RM_RPC_FRAGMENTS_MASK, cont_fragments);
> +	hdr_template.seq = cpu_to_le16(connection->reply.seq);
> +	hdr_template.msg_id = cpu_to_le32(message_id);
> +
> +	ret = mutex_lock_interruptible(&rm->send_lock);
> +	if (ret)
> +		return ret;
> +
> +	do {
> +		msg = kmem_cache_zalloc(rm->cache, GFP_KERNEL);

Per the rm->send_lock() we can only have one msg outstanding at any
point in time. So you should be able to allocate one of those at probe
time and be done with it.

> +		if (!msg) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}
> +
> +		/* Fill header */
> +		hdr = (struct gh_rm_rpc_hdr *)&msg->data[0];
> +		*hdr = hdr_template;
> +
> +		/* Copy payload */
> +		payload = &msg->data[0] + sizeof(*hdr);
> +		payload_size = min(buf_size_remaining, GH_RM_MAX_MSG_SIZE);
> +		memcpy(payload, req_buf_curr, payload_size);
> +		req_buf_curr += payload_size;
> +		buf_size_remaining -= payload_size;
> +
> +		/* Force the last fragment to immediately alert the receiver */
> +		msg->push = !buf_size_remaining;
> +		msg->length = sizeof(*hdr) + payload_size;
> +
> +		ret = mbox_send_message(gh_msgq_chan(&rm->msgq), msg);

This would be much cleaner if it was just an optional wait for pending
tx irq and a synchronous call to gh_hypercall_msgq_send().

> +		if (ret < 0) {
> +			kmem_cache_free(rm->cache, msg);
> +			break;
> +		}
> +
> +		if (rm->last_tx_ret) {
> +			ret = rm->last_tx_ret;
> +			break;
> +		}
> +
> +		hdr_template.type = FIELD_PREP(RM_RPC_TYPE_MASK, RM_RPC_TYPE_CONTINUATION) |
> +					FIELD_PREP(RM_RPC_FRAGMENTS_MASK, cont_fragments);
> +	} while (buf_size_remaining);
> +
> +out:
> +	mutex_unlock(&rm->send_lock);
> +	return ret < 0 ? ret : 0;
> +}
> +
> +/**
> + * gh_rm_call: Achieve request-response type communication with RPC
> + * @rm: Pointer to Gunyah resource manager internal data
> + * @message_id: The RM RPC message-id
> + * @req_buf: Request buffer that contains the payload
> + * @req_buf_size: Total size of the payload
> + * @resp_buf: Pointer to a response buffer
> + * @resp_buf_size: Size of the response buffer
> + *
> + * Make a request to the Resource Manager and wait for reply back. For a successful
> + * response, the function returns the payload. The size of the payload is set in
> + * resp_buf_size. The resp_buf must be freed by the caller when 0 is returned
> + * and resp_buf_size != 0.
> + *
> + * req_buf should be not NULL for req_buf_size >0. If req_buf_size == 0,
> + * req_buf *can* be NULL and no additional payload is sent.
> + *
> + * Context: Process context. Will sleep waiting for reply.
> + * Return: 0 on success. <0 if error.
> + */
> +int gh_rm_call(struct gh_rm *rm, u32 message_id, const void *req_buf, size_t req_buf_size,
> +		void **resp_buf, size_t *resp_buf_size)
> +{
> +	struct gh_rm_connection *connection;
> +	u32 seq_id;
> +	int ret;
> +
> +	/* message_id 0 is reserved. req_buf_size implies req_buf is not NULL */
> +	if (!rm || !message_id || (!req_buf && req_buf_size))
> +		return -EINVAL;
> +
> +
> +	connection = kzalloc(sizeof(*connection), GFP_KERNEL);

No matter how many times I read this code, this isn't "a connection" it
is the response message.

sizeof(*connection) doesn't seem too bad either, so you should be able
to just store it on the stack.

> +	if (!connection)
> +		return -ENOMEM;
> +
> +	connection->type = RM_RPC_TYPE_REPLY;
> +	connection->msg_id = cpu_to_le32(message_id);
> +
> +	init_completion(&connection->reply.seq_done);
> +
> +	/* Allocate a new seq number for this connection */
> +	ret = xa_alloc_cyclic(&rm->call_xarray, &seq_id, connection, xa_limit_16b, &rm->next_seq,
> +				GFP_KERNEL);
> +	if (ret < 0)
> +		goto free;
> +	connection->reply.seq = lower_16_bits(seq_id);

You use connection->reply.seq for two things; 1) as a local variable, 2)
to pass the sequence id as an argument to gh_rm_send_request().

Further more, reply.seq is the only thing extracted from "connection" in
gh_rm_send_request(), so if you passed that directly instead of the
"connection" #2 is gone and you're down to duplicating the variable
already on the stack...

So you can remove "seq" from struct gh_rm_connection...

> +
> +	/* Send the request to the Resource Manager */
> +	ret = gh_rm_send_request(rm, message_id, req_buf, req_buf_size, connection);
> +	if (ret < 0)
> +		goto out;
> +
> +	/* Wait for response. Uninterruptible because rollback based on what RM did to VM

/*
 * Multi-line comments should generally be started on the second line.
 */

> +	 * requires us to know how RM handled the call.
> +	 */
> +	wait_for_completion(&connection->reply.seq_done);
> +
> +	/* Check for internal (kernel) error waiting for the response */
> +	if (connection->reply.ret) {
> +		ret = connection->reply.ret;
> +		if (ret != -ENOMEM)
> +			kfree(connection->payload);
> +		goto out;
> +	}
> +
> +	/* Got a response, did resource manager give us an error? */
> +	if (connection->reply.rm_error != GH_RM_ERROR_OK) {
> +		dev_warn(rm->dev, "RM rejected message %08x. Error: %d\n", message_id,
> +			connection->reply.rm_error);
> +		ret = gh_rm_error_remap(connection->reply.rm_error);
> +		kfree(connection->payload);
> +		goto out;
> +	}
> +
> +	/* Everything looks good, return the payload */
> +	if (resp_buf_size)
> +		*resp_buf_size = connection->size;
> +	if (connection->size && resp_buf)

Keep {} around all blocks if anyone of them need it.

> +		*resp_buf = connection->payload;
> +	else {
> +		/* kfree in case RM sent us multiple fragments but never any data in
> +		 * those fragments. We would've allocated memory for it, but connection->size == 0
> +		 */
> +		kfree(connection->payload);
> +	}
> +
> +out:
> +	xa_erase(&rm->call_xarray, connection->reply.seq);
> +free:
> +	kfree(connection);
> +	return ret;
> +}
> +
> +
> +int gh_rm_notifier_register(struct gh_rm *rm, struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_register(&rm->nh, nb);
> +}
> +EXPORT_SYMBOL_GPL(gh_rm_notifier_register);
> +
> +int gh_rm_notifier_unregister(struct gh_rm *rm, struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_unregister(&rm->nh, nb);
> +}
> +EXPORT_SYMBOL_GPL(gh_rm_notifier_unregister);
> +
> +static int gh_msgq_platform_probe_direction(struct platform_device *pdev, bool tx,
> +					    struct gh_resource *ghrsc)
> +{
> +	struct device_node *node = pdev->dev.of_node;
> +	int ret;
> +	int idx = tx ? 0 : 1;
> +
> +	ghrsc->type = tx ? GH_RESOURCE_TYPE_MSGQ_TX : GH_RESOURCE_TYPE_MSGQ_RX;
> +
> +	ghrsc->irq = platform_get_irq(pdev, idx);
> +	if (ghrsc->irq < 0) {
> +		dev_err(&pdev->dev, "Failed to get irq%d: %d\n", idx, ghrsc->irq);

"irq0"/"irq1" won't help the reader much.

... "Failed to get %s irq: %d\n", tx ? "tx" : "rx", ghrsc->irq);

> +		return ghrsc->irq;
> +	}
> +
> +	ret = of_property_read_u64_index(node, "reg", idx, &ghrsc->capid);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to get capid%d: %d\n", idx, ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int gh_identify(void)
> +{
> +	struct gh_hypercall_hyp_identify_resp gh_api;
> +
> +	if (!arch_is_gh_guest())
> +		return -ENODEV;
> +
> +	gh_hypercall_hyp_identify(&gh_api);
> +
> +	pr_info("Running under Gunyah hypervisor %llx/v%u\n",
> +		FIELD_GET(GH_API_INFO_VARIANT_MASK, gh_api.api_info),
> +		gh_api_version(&gh_api));
> +
> +	/* We might move this out to individual drivers if there's ever an API version bump */
> +	if (gh_api_version(&gh_api) != GH_API_V1) {
> +		pr_info("Unsupported Gunyah version: %u\n", gh_api_version(&gh_api));

Is this just an informational statement?

> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
> +static int gh_rm_drv_probe(struct platform_device *pdev)

Does "_drv_" add value to this function name?

> +{
> +	struct gh_msgq_tx_data *msg;
> +	struct gh_rm *rm;
> +	int ret;
> +
> +	ret = gh_identify();
> +	if (ret)
> +		return ret;
> +
> +	rm = devm_kzalloc(&pdev->dev, sizeof(*rm), GFP_KERNEL);
> +	if (!rm)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, rm);
> +	rm->dev = &pdev->dev;
> +
> +	mutex_init(&rm->send_lock);
> +	BLOCKING_INIT_NOTIFIER_HEAD(&rm->nh);
> +	xa_init_flags(&rm->call_xarray, XA_FLAGS_ALLOC);
> +	rm->cache = kmem_cache_create("gh_rm", struct_size(msg, data, GH_MSGQ_MAX_MSG_SIZE), 0,
> +		SLAB_HWCACHE_ALIGN, NULL);
> +	if (!rm->cache)
> +		return -ENOMEM;
> +
> +	ret = gh_msgq_platform_probe_direction(pdev, true, &rm->tx_ghrsc);
> +	if (ret)
> +		goto err_cache;
> +
> +	ret = gh_msgq_platform_probe_direction(pdev, false, &rm->rx_ghrsc);
> +	if (ret)
> +		goto err_cache;
> +
> +	rm->msgq_client.dev = &pdev->dev;
> +	rm->msgq_client.tx_block = true;
> +	rm->msgq_client.rx_callback = gh_rm_msgq_rx_data;
> +	rm->msgq_client.tx_done = gh_rm_msgq_tx_done;
> +
> +	return gh_msgq_init(&pdev->dev, &rm->msgq, &rm->msgq_client, &rm->tx_ghrsc, &rm->rx_ghrsc);
> +err_cache:
> +	kmem_cache_destroy(rm->cache);
> +	return ret;
> +}
> +
> +static int gh_rm_drv_remove(struct platform_device *pdev)
> +{
> +	struct gh_rm *rm = platform_get_drvdata(pdev);
> +
> +	gh_msgq_remove(&rm->msgq);
> +	kmem_cache_destroy(rm->cache);
> +

As soon as you return here, "rm" will be freed by devres (it's not tied
to the refcount of the struct device). If you have any outstanding
notification work, that will result in a use-after-free.

> +	return 0;
> +}
> +
> +static const struct of_device_id gh_rm_of_match[] = {
> +	{ .compatible = "gunyah-resource-manager" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, gh_rm_of_match);
> +
> +static struct platform_driver gh_rm_driver = {
> +	.probe = gh_rm_drv_probe,
> +	.remove = gh_rm_drv_remove,
> +	.driver = {
> +		.name = "gh_rsc_mgr",
> +		.of_match_table = gh_rm_of_match,
> +	},
> +};
> +module_platform_driver(gh_rm_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Gunyah Resource Manager Driver");
> diff --git a/drivers/virt/gunyah/rsc_mgr.h b/drivers/virt/gunyah/rsc_mgr.h
> new file mode 100644
> index 0000000000000..8309b7bf46683
> --- /dev/null
> +++ b/drivers/virt/gunyah/rsc_mgr.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +#ifndef __GH_RSC_MGR_PRIV_H
> +#define __GH_RSC_MGR_PRIV_H
> +
> +#include <linux/gunyah.h>
> +#include <linux/gunyah_rsc_mgr.h>

You declare struct gh_rm below, so do you really need these two
includes?

> +#include <linux/types.h>
> +
> +struct gh_rm;

Would be nice with an empty line here.

> +int gh_rm_call(struct gh_rm *rsc_mgr, u32 message_id, const void *req_buf, size_t req_buf_size,
> +		void **resp_buf, size_t *resp_buf_size);
> +
> +#endif
> diff --git a/include/linux/gunyah_rsc_mgr.h b/include/linux/gunyah_rsc_mgr.h
> new file mode 100644
> index 0000000000000..f2a312e80af52
> --- /dev/null
> +++ b/include/linux/gunyah_rsc_mgr.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#ifndef _GUNYAH_RSC_MGR_H
> +#define _GUNYAH_RSC_MGR_H
> +
> +#include <linux/list.h>

Unused?

> +#include <linux/notifier.h>
> +#include <linux/gunyah.h>
> +
> +#define GH_VMID_INVAL		U16_MAX

Unused in this patch.

> +
> +struct gh_rm;

Would be nice with an empty line here.

> +int gh_rm_notifier_register(struct gh_rm *rm, struct notifier_block *nb);
> +int gh_rm_notifier_unregister(struct gh_rm *rm, struct notifier_block *nb);
> +struct device *gh_rm_get(struct gh_rm *rm);
> +void gh_rm_put(struct gh_rm *rm);
> +

Regards,
Bjorn
