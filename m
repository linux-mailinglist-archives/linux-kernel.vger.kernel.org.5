Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C723A7C52A3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 13:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345956AbjJKL6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 07:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjJKL6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 07:58:14 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88938F;
        Wed, 11 Oct 2023 04:58:11 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S5B7D4JYxz6K5xf;
        Wed, 11 Oct 2023 19:56:08 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 11 Oct
 2023 12:58:08 +0100
Date:   Wed, 11 Oct 2023 12:58:07 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Konstantin Aladyshev <aladyshev22@gmail.com>
CC:     <minyard@acm.org>, <joel@jms.id.au>, <andrew@aj.id.au>,
        <avifishman70@gmail.com>, <tmaimon77@gmail.com>,
        <tali.perry1@gmail.com>, <venture@google.com>, <yuenn@google.com>,
        <benjaminfair@google.com>, <jk@codeconstruct.com.au>,
        <matt@codeconstruct.com.au>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <openipmi-developer@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <openbmc@lists.ozlabs.org>,
        <netdev@vger.kernel.org>
Subject: Re: [PATCH v5 3/3] mctp: Add MCTP-over-KCS transport binding
Message-ID: <20231011125807.00004db0@Huawei.com>
In-Reply-To: <20231010122321.823-4-aladyshev22@gmail.com>
References: <20231010122321.823-1-aladyshev22@gmail.com>
        <20231010122321.823-4-aladyshev22@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2023 15:23:21 +0300
Konstantin Aladyshev <aladyshev22@gmail.com> wrote:

> This change adds a MCTP KCS transport binding, as defined by the DMTF
> specification DSP0254 - "MCTP KCS Transport Binding".
> A MCTP protocol network device is created for each KCS channel found in
> the system.
> The interrupt code for the KCS state machine is based on the current
> IPMI KCS driver.
> 
> Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>

Hi Konstantin.

Many of the comments I have inline will be more about general KCS issues
that need sorting out.  Whether this can move forwards before that
(or whether to take any noticed of this) is a question for relevant
maintainers.

BTW it's fine to propose fixes /cleanup to a subsystem alongside a new driver
if you do fancy taking on some of the issues with managed allocations etc called out.

Jonathan


> diff --git a/drivers/net/mctp/mctp-kcs.c b/drivers/net/mctp/mctp-kcs.c
> new file mode 100644
> index 000000000000..b0d903609c64
> --- /dev/null
> +++ b/drivers/net/mctp/mctp-kcs.c
> @@ -0,0 +1,600 @@


...

> +
> +static DEFINE_SPINLOCK(kcs_bmc_mctp_instances_lock);
> +static LIST_HEAD(kcs_bmc_mctp_instances);
> +
> +static int kcs_bmc_mctp_add_device(struct kcs_bmc_device *kcs_bmc)
> +{
> +	struct net_device *ndev;
> +	struct mctp_kcs *mkcs;
> +	char name[32];
> +	int rc;
> +
> +	snprintf(name, sizeof(name), "mctpkcs%d", kcs_bmc->channel);
> +
> +	ndev = alloc_netdev(sizeof(*mkcs), name, NET_NAME_ENUM, mctp_kcs_setup);
> +	if (!ndev) {
> +		dev_err_probe(kcs_bmc->dev, -ENOMEM,
> +			      "alloc_netdev failed for KCS channel %d\n",
> +			      kcs_bmc->channel);
> +		return -ENOMEM;
> +	}
> +
> +	mkcs = netdev_priv(ndev);
> +	mkcs->netdev = ndev;
> +	mkcs->client.dev = kcs_bmc;
> +	mkcs->client.ops = &kcs_bmc_mctp_client_ops;
> +	mkcs->data_in = devm_kmalloc(kcs_bmc->dev, KCS_MSG_BUFSIZ, GFP_KERNEL);
> +	if (!mkcs->data_in) {
> +		dev_err_probe(
> +			kcs_bmc->dev, -ENOMEM,
> +			"failed to allocate data_in buffer for KCS channel %d\n",
> +			kcs_bmc->channel);
> +		rc = -ENOMEM;
> +		goto free_netdev;
> +	}
> +	mkcs->data_out = devm_kmalloc(kcs_bmc->dev, KCS_MSG_BUFSIZ, GFP_KERNEL);
> +	if (!mkcs->data_out) {
> +		dev_err_probe(
> +			kcs_bmc->dev, -ENOMEM,
> +			"failed to allocate data_out buffer for KCS channel %d\n",
> +			kcs_bmc->channel);
> +		rc = -ENOMEM;
> +		goto free_netdev;
> +	}
> +
> +	INIT_WORK(&mkcs->rx_work, mctp_kcs_rx_work);
> +
> +	rc = register_netdev(ndev);
> +	if (rc)
> +		goto free_netdev;
> +
> +	spin_lock_irq(&kcs_bmc_mctp_instances_lock);
> +	list_add(&mkcs->entry, &kcs_bmc_mctp_instances);
> +	spin_unlock_irq(&kcs_bmc_mctp_instances_lock);
> +
> +	dev_info(kcs_bmc->dev, "Add MCTP client for the KCS channel %d",
> +		 kcs_bmc->channel);
> +	return 0;
> +
> +free_netdev:
> +	free_netdev(ndev);

Mixing devm and non devm is something you should not do. 
Very simple rule that must be kept to is that you stop using devm for
any calls in an add_device / probe() function at the first line that needs
manual cleanup.

Use devm_add_action_or_reset() for this case as you can add a custom
callback to the devm managed queue.

The reason this all matters is that devm cleanup happens after error paths
/ remove_device() callbacks and as such it makes a reviewer have to reason
about whether there are any dependencies that are a result of the reordering.
Tearing down in exact reverse order of setup is a lot easier to do!


> +
> +	return rc;
> +}
> +
> +static int kcs_bmc_mctp_remove_device(struct kcs_bmc_device *kcs_bmc)
> +{
> +	struct mctp_kcs *mkcs = NULL, *pos;
> +
> +	dev_info(kcs_bmc->dev, "Remove MCTP client for the KCS channel %d",
> +		 kcs_bmc->channel);
> +	spin_lock_irq(&kcs_bmc_mctp_instances_lock);
> +	list_for_each_entry(pos, &kcs_bmc_mctp_instances, entry) {

I've commented on this before, but this lookup should not be necessary.
It should be possible to go directly from kcs_bmc entry as registered
to the mctp_kcs structure.  Typical approach being to embed the structure
or using some drvdata type field that add has filled in with appropriate
pointer.

There is a need for the kcs subsystem to manage which devices it
calls this on.  Currently this also serves the purpose of filtering
for that.  If not going to do management at subsystem layer (some smaller
subsystems don't) then use an enum to add a type to kcs_bmc
and have each driver add a new one.  You can check that in driver
or in core code. Doesn't matter which as check will be trivial.


> +		if (pos->client.dev == kcs_bmc) {
> +			mkcs = pos;
> +			list_del(&pos->entry);
> +			break;
> +		}
> +	}
> +	spin_unlock_irq(&kcs_bmc_mctp_instances_lock);
> +
> +	if (!mkcs)
> +		return -ENODEV;
> +
> +	unregister_netdev(mkcs->netdev);
> +	free_netdev(mkcs->netdev);
> +	kcs_bmc_disable_device(kcs_bmc, &mkcs->client);
> +	devm_kfree(kcs_bmc->dev, mkcs->data_out);
> +	devm_kfree(kcs_bmc->dev, mkcs->data_in);

I don't like mixture of letting devm delete these on remove and
it being done manually here.

Note that if you just didn't have these two calls, they'd be deleted soon
after this exit anyway.

If devm is any use when combined with kcs, these will be freed shortly after
this anyway. If it isn't of use with this subsystem then then they won't
do the right thing in the add_device callback error cases.

I'd test if it does anything at all via each path where we'd expect it to
(driver unbind, device removal, error in add_device callback)

In all those cases the devm unwinding callbacks should be called. 
(add a bonus one for testing with devm_add_action_or_reset() and
see if that one is called in each path).

I'm very suspicious of this working as not setting the normal calls
to make it happen.
e.g. for I2c, it happens here:
https://elixir.bootlin.com/linux/latest/source/drivers/i2c/i2c-core-base.c#L597
for the error path with a call to devres_release_group()
in other subsystems it's handled by the bus_type logic which ultimately
calls device_unbind_cleanup() in probe() failure.  That calls
devres_release_all() triggering the tear down paths.

However I might be missing a route by which the cleanup happens.

Anyhow, if that is fixed, these devm cleanup calls in remove_device()
should not be here.  The whole point of devm is to simplify this - if
you manually have to unwind it the advantages go away and you should
manage things explicitly.



> +	return 0;
> +}
> +
> +static const struct kcs_bmc_driver_ops kcs_bmc_mctp_driver_ops = {
> +	.add_device = kcs_bmc_mctp_add_device,
> +	.remove_device = kcs_bmc_mctp_remove_device,
> +};
> +
> +static struct kcs_bmc_driver kcs_bmc_mctp_driver = {
> +	.ops = &kcs_bmc_mctp_driver_ops,
> +};
> +
> +static int __init mctp_kcs_init(void)
> +{
> +	kcs_bmc_register_driver(&kcs_bmc_mctp_driver);
> +	return 0;
> +}
> +
> +static void __exit mctp_kcs_exit(void)
> +{
> +	kcs_bmc_unregister_driver(&kcs_bmc_mctp_driver);
> +}
> +
> +module_init(mctp_kcs_init);
> +module_exit(mctp_kcs_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Konstantin Aladyshev <aladyshev22@gmail.com>");
> +MODULE_DESCRIPTION("MCTP KCS transport");

