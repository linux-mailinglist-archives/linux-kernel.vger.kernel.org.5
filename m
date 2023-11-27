Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8454B7FA27E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 15:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbjK0OWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 09:22:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233767AbjK0OVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 09:21:43 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6DE3872
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 06:19:04 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5652667373; Mon, 27 Nov 2023 15:18:58 +0100 (CET)
Date:   Mon, 27 Nov 2023 15:18:57 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [RFC v1] nvme: add cse, ds, ms, nsze and nuse to sysfs
Message-ID: <20231127141857.GA25833@lst.de>
References: <20231127103208.25748-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127103208.25748-1-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 11:32:08AM +0100, Daniel Wagner wrote:
> Also getting a pointer to the nvme_ns data structure is a bit strange
> (dev_to_nvme_ns).
> This stip is necessary as many of the ns attributes are in
> nvme_ns. Shouldn't these per path values not all be the same and thus couldn't
> these be in nvme_ns_head? Anyway, just not sure who to deal with this. So any
> pointers highly welcomed!

Yes, they probably should be in the ns_head.

> +		list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
> +			down_read(&ctrl->namespaces_rwsem);
> +			list_for_each_entry(ns, &ctrl->namespaces, list) {
> +				ret = ns;
> +				break;
> +			}
> +			up_read(&ctrl->namespaces_rwsem);
> +		}
> +		return ret;
> +	}

.. I also don't think this would even be safe as-is as we dont hold
a reference to the ns after dropping the lock.

> +static ssize_t csi_show(struct device *dev, struct device_attribute *attr,
> +		char *buf)
> +{
> +	return sysfs_emit(buf, "%d\n", dev_to_ns_head(dev)->ids.csi);
> +}
> +static DEVICE_ATTR_RO(csi);
> +
> +static ssize_t lba_ds_show(struct device *dev, struct device_attribute *attr,
> +		char *buf)
> +{
> +	struct nvme_ns *ns = dev_to_nvme_ns(dev);
> +
> +	return sysfs_emit(buf, "%d\n", ns->lba_shift);

lba_ds is a bit of an odd name.  And I also don't think we even need
this, because it really is just a weird enconding for the logical block
size already exposed by the block layer.

> +static ssize_t lba_ms_show(struct device *dev, struct device_attribute *attr,
> +		char *buf)
> +{
> +	struct nvme_ns *ns = dev_to_nvme_ns(dev);
> +
> +	return sysfs_emit(buf, "%d\n", ns->ms);
> +}
> +static DEVICE_ATTR_RO(lba_ms);

I'd probably spell out metadata_size, or probably even better
metadata_bytes to match the unit postfixes elsewhere in the block code.

> +
> +static ssize_t nsze_show(struct device *dev, struct device_attribute *attr,
> +		char *buf)
> +{
> +	struct nvme_ns *ns = dev_to_nvme_ns(dev);
> +
> +	return sysfs_emit(buf, "%llu\n", ns->nsze);
> +}
> +static DEVICE_ATTR_RO(nsze);

This is just the normal size of the block device we already export.

