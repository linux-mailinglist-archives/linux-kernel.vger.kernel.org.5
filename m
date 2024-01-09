Return-Path: <linux-kernel+bounces-20732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC33D828459
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 11:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 121BAB22D7A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 10:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0D936B0D;
	Tue,  9 Jan 2024 10:52:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F165436AE9;
	Tue,  9 Jan 2024 10:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 834A9C15;
	Tue,  9 Jan 2024 02:52:42 -0800 (PST)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 987FD3F73F;
	Tue,  9 Jan 2024 02:51:54 -0800 (PST)
Message-ID: <7b1f4c84-2bad-4988-a495-28b5a6b9d573@arm.com>
Date: Tue, 9 Jan 2024 10:51:52 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [PATCH v6 5/7] coresight: tmc: Add support for reading tracedata
 from previous boot
To: Linu Cherian <lcherian@marvell.com>, mike.leach@linaro.org,
 james.clark@arm.com, leo.yan@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, sgoutham@marvell.com, gcherian@marvell.com,
 Anil Kumar Reddy <areddy3@marvell.com>, Tanmay Jagdale <tanmay@marvell.com>
References: <20240105055840.1977897-1-lcherian@marvell.com>
 <20240105055840.1977897-6-lcherian@marvell.com>
Content-Language: en-GB
In-Reply-To: <20240105055840.1977897-6-lcherian@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi

On 05/01/2024 05:58, Linu Cherian wrote:
> * Introduce a new mode CS_MODE_READ_PREVBOOT for reading tracedata
>    captured in previous boot.
> 
> * Add special handlers for preparing ETR/ETF for this special mode
> 
> * User can read the trace data as below
> 
>    For example, for reading trace data from tmc_etf sink
> 
>    1. cd /sys/bus/coresight/devices/tmc_etfXX/
> 
>    2. Change mode to READ_PREVBOOT
> 
>       #echo 1 > read_prevboot

I do not like this "new mode" just for reading the crash trace.
We are in the crash kernel when we have trace metadata available. Could
we not simply expose this via /dev/tmc_xxx. We can certainly figure this
out if we are in a crashkernel or not and the trace metadata is valid.
Also, we should wipe out the trace data/metadata on a normal boot or
after the crashkernel captures the data. We don't expect the user to do
tracing in the crashkernel, even if the user does it, it is upto the
user to overwrite the trace. We could even expose a different file
for the crash trace/metadata (say /dev/tmc_xxx_crash).

But please do not bloat the existing sysfs interface.

Suzuki

> 
>    3. Dump trace buffer data to a file,
> 
>       #dd if=/dev/tmc_etfXX of=~/cstrace.bin
> 
>    4. Reset back to normal mode
> 
>       #echo 0 > read_prevboot
> 
> Signed-off-by: Anil Kumar Reddy <areddy3@marvell.com>
> Signed-off-by: Tanmay Jagdale <tanmay@marvell.com>
> Signed-off-by: Linu Cherian <lcherian@marvell.com>
> ---
> Changelog from v5:
> * Fixed issues reported by CONFIG_DEBUG_ATOMIC_SLEEP in tmc_etr_setup_prevboot_buf
>    and tmc_etb_setup_prevboot_buf
>    - Kmalloc invoked with spinlock taken is now done with GFP_ATOMIC
>    - Removed the requirement for memremap with spinlock taken. This is by
>      making a assumption that the trace buffer address used for capturing
>      trace data during kernel crash/hang would be same as that used
>      for trace data retrieval in the subsequent boot. Added additional
>      verification to ensure this.
> 
> * Fixed a memory leak in tmc_read_unprepare_etr in READ_PREVBOOT mode
> 
> 
>   .../coresight/coresight-etm4x-core.c          |   1 +
>   .../hwtracing/coresight/coresight-tmc-core.c  |  96 ++++++++++-
>   .../hwtracing/coresight/coresight-tmc-etf.c   |  73 +++++++++
>   .../hwtracing/coresight/coresight-tmc-etr.c   | 154 +++++++++++++++++-
>   drivers/hwtracing/coresight/coresight-tmc.h   |   6 +
>   include/linux/coresight.h                     |  13 ++
>   6 files changed, 341 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 34aee59dd147..c26b5f72a494 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -1010,6 +1010,7 @@ static void etm4_disable(struct coresight_device *csdev,
>   
>   	switch (mode) {
>   	case CS_MODE_DISABLED:
> +	case CS_MODE_READ_PREVBOOT:
>   		break;
>   	case CS_MODE_SYSFS:
>   		etm4_disable_sysfs(csdev);
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
> index 4d7530d6ac91..e6525c3dcf66 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-core.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
> @@ -103,6 +103,60 @@ u32 tmc_get_memwidth_mask(struct tmc_drvdata *drvdata)
>   	return mask;
>   }
>   
> +int tmc_read_prepare_prevboot(struct tmc_drvdata *drvdata)
> +{
> +	int ret = 0;
> +	struct tmc_crash_metadata *mdata;
> +	struct coresight_device *csdev = drvdata->csdev;
> +
> +	if (!drvdata->crash_mdata.vaddr) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	mdata = drvdata->crash_mdata.vaddr;
> +	/* Check data integrity of metadata */
> +	if (mdata->crc32_mdata != find_crash_metadata_crc(mdata)) {
> +		dev_dbg(&drvdata->csdev->dev,
> +			"CRC mismatch in tmc crash metadata\n");
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +	/* Check data integrity of tracedata */
> +	if (mdata->crc32_tdata != find_crash_tracedata_crc(drvdata, mdata)) {
> +		dev_dbg(&drvdata->csdev->dev,
> +			"CRC mismatch in tmc crash tracedata\n");
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +	/* Check for valid metadata */
> +	if (!mdata->valid) {
> +		dev_dbg(&drvdata->csdev->dev,
> +			"Data invalid in tmc crash metadata\n");
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	/* Sink specific prevboot mode preparation */
> +	ret = prevboot_ops(csdev)->prepare(csdev);
> +	if (ret)
> +		goto out;
> +
> +	if (mdata->sts & 0x1)
> +		coresight_insert_barrier_packet(drvdata->buf);
> +
> +out:
> +	return ret;
> +}
> +
> +int tmc_read_unprepare_prevboot(struct tmc_drvdata *drvdata)
> +{
> +	struct coresight_device *csdev = drvdata->csdev;
> +
> +	/* Sink specific prevboot mode preparation */
> +	return prevboot_ops(csdev)->unprepare(csdev);
> +}
> +
>   static int tmc_read_prepare(struct tmc_drvdata *drvdata)
>   {
>   	int ret = 0;
> @@ -153,6 +207,10 @@ static int tmc_open(struct inode *inode, struct file *file)
>   	struct tmc_drvdata *drvdata = container_of(file->private_data,
>   						   struct tmc_drvdata, miscdev);
>   
> +	/* Advertise if we are opening with a special mode */
> +	if (drvdata->mode == CS_MODE_READ_PREVBOOT)
> +		dev_dbg(&drvdata->csdev->dev, "TMC read mode for previous boot\n");
> +
>   	ret = tmc_read_prepare(drvdata);
>   	if (ret)
>   		return ret;
> @@ -331,9 +389,44 @@ static ssize_t buffer_size_store(struct device *dev,
>   
>   static DEVICE_ATTR_RW(buffer_size);
>   
> +static ssize_t read_prevboot_show(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	struct tmc_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +
> +	return sprintf(buf, "%#x\n", (drvdata->mode == CS_MODE_READ_PREVBOOT));
> +}
> +
> +static ssize_t read_prevboot_store(struct device *dev,
> +				 struct device_attribute *attr,
> +				 const char *buf, size_t size)
> +{
> +	int ret;
> +	unsigned long val, flags;
> +	struct tmc_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +
> +	ret = kstrtoul(buf, 0, &val);
> +	if (ret)
> +		return ret;
> +
> +	spin_lock_irqsave(&drvdata->spinlock, flags);
> +
> +	if (val && (drvdata->mode == CS_MODE_DISABLED))
> +		drvdata->mode = CS_MODE_READ_PREVBOOT;
> +	else if (!val && (drvdata->mode == CS_MODE_READ_PREVBOOT))
> +		drvdata->mode = CS_MODE_DISABLED;
> +
> +	spin_unlock_irqrestore(&drvdata->spinlock, flags);
> +
> +	return size;
> +}
> +
> +static DEVICE_ATTR_RW(read_prevboot);
> +
>   static struct attribute *coresight_tmc_attrs[] = {
>   	&dev_attr_trigger_cntr.attr,
>   	&dev_attr_buffer_size.attr,
> +	&dev_attr_read_prevboot.attr,
>   	NULL,
>   };
>   
> @@ -635,7 +728,8 @@ static void tmc_shutdown(struct amba_device *adev)
>   
>   	spin_lock_irqsave(&drvdata->spinlock, flags);
>   
> -	if (drvdata->mode == CS_MODE_DISABLED)
> +	if (drvdata->mode == CS_MODE_DISABLED ||
> +	    drvdata->mode == CS_MODE_READ_PREVBOOT)
>   		goto out;
>   
>   	if (drvdata->config_type == TMC_CONFIG_TYPE_ETR)
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> index b53cef7628ff..72c2315f4e23 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> @@ -648,6 +648,56 @@ static int tmc_panic_sync_etf(struct coresight_device *csdev)
>   	return 0;
>   }
>   
> +static int tmc_etb_setup_prevboot_buf(struct tmc_drvdata *drvdata)
> +{
> +	unsigned long size;
> +	struct tmc_crash_metadata *mdata;
> +	struct device *dev = &drvdata->csdev->dev;
> +
> +	mdata = drvdata->crash_mdata.vaddr;
> +	size = mdata->size << 2;
> +
> +	/*
> +	 * Buffer address given by metadata for retrieval of trace data
> +	 * from previous boot is expected to be same as the reserved
> +	 * trace buffer memory region provided through DTS
> +	 */
> +	if (is_tmc_reserved_region_valid(dev->parent)
> +	    && (drvdata->crash_tbuf.paddr == mdata->trc_paddr))
> +		drvdata->buf = drvdata->crash_tbuf.vaddr;
> +	else {
> +		dev_dbg(dev, "Trace buffer address of previous boot invalid\n");
> +		return -EINVAL;
> +	}
> +
> +	drvdata->len = size;
> +	return 0;
> +}
> +
> +static void tmc_etb_free_prevboot_buf(struct tmc_drvdata *drvdata)
> +{
> +	void *buf = drvdata->buf;
> +
> +	if (!buf)
> +		return;
> +	drvdata->buf = NULL;
> +}
> +
> +static int tmc_etb_prepare_prevboot(struct coresight_device *csdev)
> +{
> +	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +
> +	return  tmc_etb_setup_prevboot_buf(drvdata);
> +}
> +
> +static int tmc_etb_unprepare_prevboot(struct coresight_device *csdev)
> +{
> +	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +
> +	tmc_etb_free_prevboot_buf(drvdata);
> +	return 0;
> +}
> +
>   static const struct coresight_ops_sink tmc_etf_sink_ops = {
>   	.enable		= tmc_enable_etf_sink,
>   	.disable	= tmc_disable_etf_sink,
> @@ -665,6 +715,11 @@ static const struct coresight_ops_panic tmc_etf_sync_ops = {
>   	.sync		= tmc_panic_sync_etf,
>   };
>   
> +static const struct coresight_ops_prevboot tmc_etf_prevboot_ops = {
> +	.prepare	= tmc_etb_prepare_prevboot,
> +	.unprepare	= tmc_etb_unprepare_prevboot,
> +};
> +
>   const struct coresight_ops tmc_etb_cs_ops = {
>   	.sink_ops	= &tmc_etf_sink_ops,
>   };
> @@ -673,6 +728,7 @@ const struct coresight_ops tmc_etf_cs_ops = {
>   	.sink_ops	= &tmc_etf_sink_ops,
>   	.link_ops	= &tmc_etf_link_ops,
>   	.panic_ops	= &tmc_etf_sync_ops,
> +	.prevboot_ops	= &tmc_etf_prevboot_ops,
>   };
>   
>   int tmc_read_prepare_etb(struct tmc_drvdata *drvdata)
> @@ -693,6 +749,14 @@ int tmc_read_prepare_etb(struct tmc_drvdata *drvdata)
>   		goto out;
>   	}
>   
> +	if (drvdata->mode == CS_MODE_READ_PREVBOOT) {
> +		ret = tmc_read_prepare_prevboot(drvdata);
> +		if (ret)
> +			goto out;
> +		else
> +			goto mode_valid;
> +	}
> +
>   	/* Don't interfere if operated from Perf */
>   	if (drvdata->mode == CS_MODE_PERF) {
>   		ret = -EINVAL;
> @@ -716,6 +780,7 @@ int tmc_read_prepare_etb(struct tmc_drvdata *drvdata)
>   		__tmc_etb_disable_hw(drvdata);
>   	}
>   
> +mode_valid:
>   	drvdata->reading = true;
>   out:
>   	spin_unlock_irqrestore(&drvdata->spinlock, flags);
> @@ -735,8 +800,16 @@ int tmc_read_unprepare_etb(struct tmc_drvdata *drvdata)
>   			 drvdata->config_type != TMC_CONFIG_TYPE_ETF))
>   		return -EINVAL;
>   
> +
>   	spin_lock_irqsave(&drvdata->spinlock, flags);
>   
> +	if (drvdata->mode == CS_MODE_READ_PREVBOOT) {
> +		tmc_read_unprepare_prevboot(drvdata);
> +		drvdata->reading = false;
> +		spin_unlock_irqrestore(&drvdata->spinlock, flags);
> +		return 0;
> +	}
> +
>   	/* Re-enable the TMC if need be */
>   	if (drvdata->mode == CS_MODE_SYSFS) {
>   		/* There is no point in reading a TMC in HW FIFO mode */
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index 23eb35f50571..ab7521bbb2f5 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -1166,7 +1166,12 @@ ssize_t tmc_etr_get_sysfs_trace(struct tmc_drvdata *drvdata,
>   {
>   	s64 offset;
>   	ssize_t actual = len;
> -	struct etr_buf *etr_buf = drvdata->sysfs_buf;
> +	struct etr_buf *etr_buf;
> +
> +	if (drvdata->mode == CS_MODE_READ_PREVBOOT)
> +		etr_buf = drvdata->prevboot_buf;
> +	else
> +		etr_buf = drvdata->sysfs_buf;
>   
>   	if (pos + actual > etr_buf->len)
>   		actual = etr_buf->len - pos;
> @@ -1873,6 +1878,130 @@ static int tmc_panic_sync_etr(struct coresight_device *csdev)
>   	return 0;
>   }
>   
> +static int tmc_etr_setup_prevboot_buf(struct tmc_drvdata *drvdata)
> +{
> +	int rc = 0;
> +	u64 trace_addr;
> +	struct etr_buf *etr_buf;
> +	struct etr_flat_buf *resrv_buf;
> +	struct tmc_crash_metadata *mdata;
> +	struct device *dev = &drvdata->csdev->dev;
> +
> +	mdata = drvdata->crash_mdata.vaddr;
> +
> +	etr_buf = kzalloc(sizeof(*etr_buf), GFP_ATOMIC);
> +	if (!etr_buf) {
> +		rc = -ENOMEM;
> +		goto out;
> +	}
> +	etr_buf->size = drvdata->crash_tbuf.size;
> +
> +	resrv_buf = kzalloc(sizeof(*resrv_buf), GFP_ATOMIC);
> +	if (!resrv_buf) {
> +		rc = -ENOMEM;
> +		goto rmem_err;
> +	}
> +
> +	/*
> +	 * Buffer address given by metadata for retrieval of trace data
> +	 * from previous boot is expected to be same as the reserved
> +	 * trace buffer memory region provided through DTS
> +	 */
> +	if (is_tmc_reserved_region_valid(dev->parent)
> +	    && (drvdata->crash_tbuf.paddr == mdata->trc_paddr))
> +		resrv_buf->vaddr = drvdata->crash_tbuf.vaddr;
> +	else {
> +		dev_dbg(dev, "Trace buffer address of previous boot invalid\n");
> +		rc = -EINVAL;
> +		goto map_err;
> +	}
> +
> +	resrv_buf->size = etr_buf->size;
> +	resrv_buf->dev = &drvdata->csdev->dev;
> +	etr_buf->hwaddr = trace_addr;
> +	etr_buf->mode = ETR_MODE_RESRV;
> +	etr_buf->private = resrv_buf;
> +	etr_buf->ops = etr_buf_ops[ETR_MODE_RESRV];
> +
> +	drvdata->prevboot_buf = etr_buf;
> +
> +	return 0;
> +
> +map_err:
> +	kfree(resrv_buf);
> +
> +rmem_err:
> +	kfree(etr_buf);
> +
> +out:
> +	return rc;
> +}
> +
> +static int tmc_etr_sync_prevboot_buf(struct tmc_drvdata *drvdata)
> +{
> +	u32 status;
> +	u64 rrp, rwp, dba;
> +	struct tmc_crash_metadata *mdata;
> +	struct etr_buf *etr_buf = drvdata->prevboot_buf;
> +
> +	mdata = drvdata->crash_mdata.vaddr;
> +
> +	rrp = mdata->rrp;
> +	rwp = mdata->rwp;
> +	dba = mdata->dba;
> +	status = mdata->sts;
> +
> +	etr_buf->full = !!(status & TMC_STS_FULL);
> +
> +	/* Sync the buffer pointers */
> +	etr_buf->offset = rrp - dba;
> +	if (etr_buf->full)
> +		etr_buf->len = etr_buf->size;
> +	else
> +		etr_buf->len = rwp - rrp;
> +
> +	/* Additional sanity checks for validating metadata */
> +	if ((etr_buf->offset > etr_buf->size) ||
> +	    (etr_buf->len > etr_buf->size)) {
> +		dev_dbg(&drvdata->csdev->dev,
> +			"Offset and length invalid in tmc crash metadata\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static void tmc_etr_free_prevboot_buf(struct tmc_drvdata *drvdata)
> +{
> +	struct etr_buf *etr_buf = drvdata->prevboot_buf;
> +
> +	if (!etr_buf)
> +		return;
> +	drvdata->prevboot_buf = NULL;
> +}
> +
> +static int tmc_etr_prepare_prevboot(struct coresight_device *csdev)
> +{
> +	int ret = 0;
> +	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +
> +	ret = tmc_etr_setup_prevboot_buf(drvdata);
> +	if (ret)
> +		goto out;
> +	ret = tmc_etr_sync_prevboot_buf(drvdata);
> +
> +out:
> +	return ret;
> +}
> +
> +static int tmc_etr_unprepare_prevboot(struct coresight_device *csdev)
> +{
> +	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +
> +	tmc_etr_free_prevboot_buf(drvdata);
> +	return 0;
> +}
> +
>   static const struct coresight_ops_sink tmc_etr_sink_ops = {
>   	.enable		= tmc_enable_etr_sink,
>   	.disable	= tmc_disable_etr_sink,
> @@ -1885,9 +2014,15 @@ static const struct coresight_ops_panic tmc_etr_sync_ops = {
>   	.sync		= tmc_panic_sync_etr,
>   };
>   
> +static const struct coresight_ops_prevboot tmc_etr_prevboot_ops = {
> +	.prepare	= tmc_etr_prepare_prevboot,
> +	.unprepare	= tmc_etr_unprepare_prevboot,
> +};
> +
>   const struct coresight_ops tmc_etr_cs_ops = {
>   	.sink_ops	= &tmc_etr_sink_ops,
>   	.panic_ops	= &tmc_etr_sync_ops,
> +	.prevboot_ops	= &tmc_etr_prevboot_ops,
>   };
>   
>   int tmc_read_prepare_etr(struct tmc_drvdata *drvdata)
> @@ -1899,12 +2034,21 @@ int tmc_read_prepare_etr(struct tmc_drvdata *drvdata)
>   	if (WARN_ON_ONCE(drvdata->config_type != TMC_CONFIG_TYPE_ETR))
>   		return -EINVAL;
>   
> +
>   	spin_lock_irqsave(&drvdata->spinlock, flags);
>   	if (drvdata->reading) {
>   		ret = -EBUSY;
>   		goto out;
>   	}
>   
> +	if (drvdata->mode == CS_MODE_READ_PREVBOOT) {
> +		ret = tmc_read_prepare_prevboot(drvdata);
> +		if (ret)
> +			goto out;
> +		else
> +			goto mode_valid;
> +	}
> +
>   	/*
>   	 * We can safely allow reads even if the ETR is operating in PERF mode,
>   	 * since the sysfs session is captured in mode specific data.
> @@ -1919,6 +2063,7 @@ int tmc_read_prepare_etr(struct tmc_drvdata *drvdata)
>   	if (drvdata->mode == CS_MODE_SYSFS)
>   		__tmc_etr_disable_hw(drvdata);
>   
> +mode_valid:
>   	drvdata->reading = true;
>   out:
>   	spin_unlock_irqrestore(&drvdata->spinlock, flags);
> @@ -1937,6 +2082,12 @@ int tmc_read_unprepare_etr(struct tmc_drvdata *drvdata)
>   
>   	spin_lock_irqsave(&drvdata->spinlock, flags);
>   
> +	if (drvdata->mode == CS_MODE_READ_PREVBOOT) {
> +		sysfs_buf = drvdata->prevboot_buf;
> +		tmc_read_unprepare_prevboot(drvdata);
> +		goto out;
> +	}
> +
>   	/* RE-enable the TMC if need be */
>   	if (drvdata->mode == CS_MODE_SYSFS) {
>   		/*
> @@ -1954,6 +2105,7 @@ int tmc_read_unprepare_etr(struct tmc_drvdata *drvdata)
>   		drvdata->sysfs_buf = NULL;
>   	}
>   
> +out:
>   	drvdata->reading = false;
>   	spin_unlock_irqrestore(&drvdata->spinlock, flags);
>   
> diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
> index 6f13caae6495..6e1e910d5ea4 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc.h
> +++ b/drivers/hwtracing/coresight/coresight-tmc.h
> @@ -216,6 +216,9 @@ struct tmc_resrv_buf {
>    * @idr_mutex:	Access serialisation for idr.
>    * @sysfs_buf:	SYSFS buffer for ETR.
>    * @perf_buf:	PERF buffer for ETR.
> + * @prevboot_buf: Previous boot buffer for ETR. This is a special purpose
> + *		buffer that is used only for mapping the trace buffer from
> + *		previous boot and not for capturing trace.
>    * @crash_tbuf: Used by ETR as hardware trace buffer and for trace data
>    *		retention (after crash) only when ETR_MODE_RESRV buffer
>    *		mode is enabled. Used by ETF for trace data retention
> @@ -247,6 +250,7 @@ struct tmc_drvdata {
>   	struct mutex		idr_mutex;
>   	struct etr_buf		*sysfs_buf;
>   	struct etr_buf		*perf_buf;
> +	struct etr_buf		*prevboot_buf;
>   	struct tmc_resrv_buf	crash_tbuf;
>   	struct tmc_resrv_buf	crash_mdata;
>   };
> @@ -298,6 +302,8 @@ void tmc_flush_and_stop(struct tmc_drvdata *drvdata);
>   void tmc_enable_hw(struct tmc_drvdata *drvdata);
>   void tmc_disable_hw(struct tmc_drvdata *drvdata);
>   u32 tmc_get_memwidth_mask(struct tmc_drvdata *drvdata);
> +int tmc_read_prepare_prevboot(struct tmc_drvdata *drvdata);
> +int tmc_read_unprepare_prevboot(struct tmc_drvdata *drvdata);
>   
>   /* ETB/ETF functions */
>   int tmc_read_prepare_etb(struct tmc_drvdata *drvdata);
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index 4fd518738958..9f84decf1d7a 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -294,6 +294,7 @@ enum cs_mode {
>   	CS_MODE_DISABLED,
>   	CS_MODE_SYSFS,
>   	CS_MODE_PERF,
> +	CS_MODE_READ_PREVBOOT, /* Trace data from previous boot */
>   };
>   
>   #define source_ops(csdev)	csdev->ops->source_ops
> @@ -302,6 +303,7 @@ enum cs_mode {
>   #define helper_ops(csdev)	csdev->ops->helper_ops
>   #define ect_ops(csdev)		csdev->ops->ect_ops
>   #define panic_ops(csdev)	csdev->ops->panic_ops
> +#define prevboot_ops(csdev)	csdev->ops->prevboot_ops
>   
>   /**
>    * struct coresight_ops_sink - basic operations for a sink
> @@ -381,12 +383,23 @@ struct coresight_ops_panic {
>   	int (*sync)(struct coresight_device *csdev);
>   };
>   
> +/**
> + * struct coresight_ops_prevboot - Generic device ops for prevboot mode
> + *
> + * @prepare	: Preparation for prevboot mode
> + */
> +struct coresight_ops_prevboot {
> +	int (*prepare)(struct coresight_device *csdev);
> +	int (*unprepare)(struct coresight_device *csdev);
> +};
> +
>   struct coresight_ops {
>   	const struct coresight_ops_sink *sink_ops;
>   	const struct coresight_ops_link *link_ops;
>   	const struct coresight_ops_source *source_ops;
>   	const struct coresight_ops_helper *helper_ops;
>   	const struct coresight_ops_panic *panic_ops;
> +	const struct coresight_ops_prevboot *prevboot_ops;
>   };
>   
>   #if IS_ENABLED(CONFIG_CORESIGHT)


