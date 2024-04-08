Return-Path: <linux-kernel+bounces-135204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA1B89BCAD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 637C41F2291D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D718B52F7E;
	Mon,  8 Apr 2024 10:08:56 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C62A524CB;
	Mon,  8 Apr 2024 10:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712570935; cv=none; b=NumFiTdndTGAdXSJq+mMBeQ/Qe/bT0NE7g/nyAgiYBTTgJc3sVL0CpKmVifwnCGLbt1cMKkAIozgZUeGkAPdTyR0tqVR7xDWP6dpzKC/sESTQCfvqG5LA+k7DelsTeikRMaL7kt7EfWeSF46v3yNMFetXs4maHvYaSpPuM6kC88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712570935; c=relaxed/simple;
	bh=Np/MKGwL97TKG+mr0sjW9Jm/Zt1DjpiidBX5FRwm54g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OQMvkiEDDmIYWZ7LfvHo0IUV53Aki8aOHpCS9kVsJt7ECXFwrK3CA2E7CboZfkblMFOTQPROlxHA9wt2ssETBRcsSESj9oP+Gci5bwOfqYwwGmwfqiydg+Xmk6vSqPxucdhgNh45LsTcrHUASB/fa7AK86qFFcmPh9bj4o2404w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 478B91007;
	Mon,  8 Apr 2024 03:09:23 -0700 (PDT)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A4CA3F766;
	Mon,  8 Apr 2024 03:08:51 -0700 (PDT)
Date: Mon, 8 Apr 2024 11:08:48 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, sudeep.holla@arm.com,
	jassisinghbrar@gmail.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Subject: Re: [PATCH v3 2/2] mailbox: arm_mhuv3: Add driver
Message-ID: <ZhPCMPbz9PxZI7PU@pluto>
References: <20240404062347.3219795-1-cristian.marussi@arm.com>
 <20240404062347.3219795-3-cristian.marussi@arm.com>
 <20240405113200.00002da9@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405113200.00002da9@Huawei.com>

On Fri, Apr 05, 2024 at 11:32:00AM +0100, Jonathan Cameron wrote:
> On Thu,  4 Apr 2024 07:23:47 +0100
> Cristian Marussi <cristian.marussi@arm.com> wrote:
> 
> > Add support for ARM MHUv3 mailbox controller.
> > 
> > Support is limited to the MHUv3 Doorbell extension using only the PBX/MBX
> > combined interrupts.
> > 
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> Drive by review (I was curious what this was :)
> 

You're welcome...thanks for having a look !

> 
> > diff --git a/drivers/mailbox/arm_mhuv3.c b/drivers/mailbox/arm_mhuv3.c
> > new file mode 100644
> > index 000000000000..e4125568bec0
> > --- /dev/null
> > +++ b/drivers/mailbox/arm_mhuv3.c
> > @@ -0,0 +1,1063 @@
> 
> > +struct dummy_page {
> > +	u8 pad[0x1000];
> > +} __packed;
> > +
> > +struct mhu3_pbx_frame_reg {
> > +	struct ctrl_page ctrl;
> > +	struct pdbcw_page dbcw[MHUV3_DBCW_MAX];
> > +	struct dummy_page ffcw;
> > +	struct dummy_page fcw;
> > +	u8 pad[0xF000 - 0x4000];
> > +	struct dummy_page impdef;
> > +} __packed;
> > +
> > +struct mhu3_mbx_frame_reg {
> > +	struct ctrl_page ctrl;
> > +	struct mdbcw_page dbcw[MHUV3_DBCW_MAX];
> > +	struct dummy_page ffcw;
> > +	struct dummy_page fcw;
> > +	u8 pad[0xF000 - 0x4000];
> Magic, numbers,  Maybe give them a definition or base them on something
> meaningful such as structure offsets? 
> 

Yes, it is indeed cryptic, these are the holes in the MMIO regs and
are derived from the spec...I'll see how I can rework to make this more
meaningful and better commented.

> > +	struct dummy_page impdef;
> > +} __packed;
> > +
> > +/* Macro for reading a bitfield within a physically mapped packed struct */
> > +#define readl_relaxed_bitfield(_regptr, _field)				\
> > +	({								\
> > +		u32 _rval;						\
> > +		typeof(_regptr) _rptr = _regptr;			\
> > +		_rval = readl_relaxed(_rptr);				\
> > +		((typeof(*_rptr) __force *)(&_rval))->_field;		\
> > +	})
> > +
> > +/* Macro for writing a bitfield within a physically mapped packed struct */
> > +#define writel_relaxed_bitfield(_value, _regptr, _field)		\
> > +	({								\
> > +		u32 _rval;						\
> > +		typeof(_regptr) _rptr = _regptr;			\
> > +		_rval = readl_relaxed(_rptr);				\
> > +		((typeof(*_rptr) __force *)(&_rval))->_field = _value;	\
> > +		writel_relaxed(_rval, _rptr);				\
> > +	})
> Similar, yet slightly different from ones in arm_mhuv2.c?  Why the differences
> and can these be shared code in a suitable header?

Yes, all the struct/bitfield based MMIO stuff is borrowed from mhuv2
since it seemed more slick than a zillions defines and bitmasks (but maybe
not exempt from issues... given what Jassi jas commented later on...), BUT
while using those I saw the opportunity to drop a parameter since v2 has a
_type arg that it can indeed derived from _regptr, so making the macros less
cumbersome to invoke....THEN sparse quicly reminded me that by using typeof()
to derive the type of the local work-variable I was also grabbing all the
related attributes attached to _regptr...namely __iomem and noderef that
triggered a bunch of warnings (unjustified since operating on a local
var NOT a real MMIO): that is the reason for the dance with __force
here, and why is not needed in v2.

> > +
> > +/* ====== MHUv3 data structures ====== */
> > +
> > +enum mhuv3_frame {
> > +	PBX_FRAME,
> > +	MBX_FRAME
> Trailing commas for last entries in enums unless they are in some sense terminators.
> > +};
> > +
> > +static char *mhuv3_str[] = {
> > +	"PBX",
> > +	"MBX"
> > +};
> > +
> > +enum mhuv3_extension_type {
> > +	FIRST_EXT = 0,
> As mentioned inline, 0 is kind of default assumption for first so I wouldn't define it.
> 

Indeed.

> > +	DBE_EXT = FIRST_EXT,
> > +	FCE_EXT,
> > +	FE_EXT,
> > +	MAX_EXT
> That's one past normal meeting of MAX,  maybe call it COUNT, or NUM?
> 

Ok.

> > +};
> 
> > +static int mhuv3_doorbell_send_data(struct mhuv3 *mhu, struct mbox_chan *chan,
> > +				    void *arg)
> > +{
> > +	int ret = 0;
> > +	struct mhuv3_mbox_chan_priv *priv = chan->con_priv;
> > +	struct mhuv3_extension *e = mhu->ext[DBE_EXT];
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&e->pending_lock, flags);
> 
> guard()  then you can do earlier returns and end up with cleaner code.
>

Yes, I'll have a look into cleanup.h at large.
 
> 
> > +	/* Only one in-flight Transfer is allowed per-doorbell */
> > +	if (!(e->pending_db[priv->ch_idx] & BIT(priv->doorbell))) {
> > +		e->pending_db[priv->ch_idx] |= BIT(priv->doorbell);
> > +		writel_relaxed(BIT(priv->doorbell),
> > +			       &mhu->pbx->dbcw[priv->ch_idx].set);
> > +	} else {
> > +		ret = -EBUSY;
> > +	}
> > +	spin_unlock_irqrestore(&e->pending_lock, flags);
> > +
> > +	return ret;
> > +}
> >
> > +
> > +static struct mbox_chan *mhuv3_dbe_chan_from_comb_irq_get(struct mhuv3 *mhu)
> > +{
> > +	int i;
> > +	struct mhuv3_extension *e = mhu->ext[DBE_EXT];
> > +	struct device *dev = mhu->mbox.dev;
> > +
> > +	for (i = 0; i < MHUV3_DBCH_CMB_INT_ST_REG_CNT; i++) {
> > +		unsigned int channel, db = MHUV3_INVALID_DOORBELL;
> > +		u32 cmb_st, st;
> > +
> > +		cmb_st = readl_relaxed(&mhu->ctrl->dbch_int_st[i]);
> > +		if (!cmb_st)
> > +			continue;
> > +
> > +		channel = i * MHUV3_STAT_BITS + __builtin_ctz(cmb_st);
> > +		if (channel >= e->max_chans) {
> > +			dev_err(dev, "Invalid %s channel:%d\n",
> > +				mhuv3_str[mhu->frame], channel);
> 
> return here rather than breaking out the loop. It is easier to follow
> given nothing is done after the loop
> 

Ok.

> > +			break;
> > +		}
> > +
> > +		if (mhu->frame == PBX_FRAME) {
> > +			unsigned long flags;
> > +			u32 active_dbs, fired_dbs;
> > +
> > +			st = readl_relaxed_bitfield(&mhu->pbx->dbcw[channel].int_st,
> > +						    tfr_ack);
> > +			if (!st) {
> > +				dev_warn(dev, "Spurios IRQ on %s channel:%d\n",
> Spell check.  Spurious.
>

Yes.
 
> > +					 mhuv3_str[mhu->frame], channel);
> > +				continue;
> > +			}
> > +
> > +			active_dbs = readl_relaxed(&mhu->pbx->dbcw[channel].st);
> > +			spin_lock_irqsave(&e->pending_lock, flags);
> > +			fired_dbs = e->pending_db[channel] & ~active_dbs;
> > +			if (fired_dbs) {
> > +				db = __builtin_ctz(fired_dbs);
> > +				e->pending_db[channel] &= ~BIT(db);
> > +				fired_dbs &= ~BIT(db);
> > +			}
> > +			spin_unlock_irqrestore(&e->pending_lock, flags);
> > +
> > +			/* Clear TFR Ack if no more doorbells pending */
> > +			if (!fired_dbs)
> > +				writel_relaxed_bitfield(0x1,
> > +							&mhu->pbx->dbcw[channel].int_clr,
> > +							tfr_ack);
> > +		} else {
> > +			st = readl_relaxed(&mhu->mbx->dbcw[channel].st_msk);
> > +			if (!st) {
> > +				dev_warn(dev, "Spurios IRQ on %s channel:%d\n",
> > +					 mhuv3_str[mhu->frame], channel);
> > +				continue;
> > +			}
> > +			db = __builtin_ctz(st);
> > +		}
> > +
> > +		if (db != MHUV3_INVALID_DOORBELL) {
> > +			dev_dbg(dev, "Found %s ch[%d]/db[%d]\n",
> > +				mhuv3_str[mhu->frame], channel, db);
> > +
> > +			return &mhu->mbox.chans[channel * MHUV3_STAT_BITS + db];
> > +		}
> > +	}
> > +
> > +	return ERR_PTR(-EIO);
> > +}
> > +
> > +static int mhuv3_dbe_init(struct mhuv3 *mhu)
> > +{
> > +	struct mhuv3_extension *e;
> > +	struct device *dev = mhu->mbox.dev;
> > +
> > +	if (!readl_relaxed_bitfield(&mhu->ctrl->feat_spt0, dbe_spt))
> > +		return 0;
> > +
> > +	dev_dbg(dev, "%s: Initializing DBE Extension.\n", mhuv3_str[mhu->frame]);
> > +
> > +	e = devm_kzalloc(dev, sizeof(*e), GFP_KERNEL);
> > +	if (!e)
> > +		return -ENOMEM;
> > +
> > +	e->type = DBE_EXT;
> > +	/* Note that, by the spec, the number of channels is (num_dbch + 1) */
> > +	e->max_chans =
> > +		readl_relaxed_bitfield(&mhu->ctrl->dbch_cfg0, num_dbch) + 1;
> > +	e->mbox_of_xlate = mhuv3_dbe_mbox_of_xlate;
> > +	e->combined_irq_setup = mhuv3_dbe_combined_irq_setup;
> > +	e->channels_init = mhuv3_dbe_channels_init;
> > +	e->chan_from_comb_irq_get = mhuv3_dbe_chan_from_comb_irq_get;
> > +
> > +	mhu->tot_chans += e->max_chans * MHUV3_STAT_BITS;
> > +	mhu->ext[DBE_EXT] = e;
> > +
> > +	dev_info(dev, "%s: found %d DBE channels.\n",
> > +		 mhuv3_str[mhu->frame], e->max_chans);
> dev_dbg() probably more appropriate.
> 

Ok.

> > +
> > +	return 0;
> > +}
> > +
> > +static int mhuv3_fce_init(struct mhuv3 *mhu)
> > +{
> > +	struct device *dev = mhu->mbox.dev;
> > +
> > +	if (!readl_relaxed_bitfield(&mhu->ctrl->feat_spt0, fce_spt))
> > +		return 0;
> > +
> > +	dev_dbg(dev, "%s: FCE Extension not supported by driver.\n",
> > +		mhuv3_str[mhu->frame]);
> > +
> > +	return 0;
> > +}
> > +
> > +static int mhuv3_fe_init(struct mhuv3 *mhu)
> > +{
> > +	struct device *dev = mhu->mbox.dev;
> > +
> > +	if (!readl_relaxed_bitfield(&mhu->ctrl->feat_spt0, fe_spt))
> > +		return 0;
> > +
> > +	dev_dbg(dev, "%s: FE Extension not supported by driver.\n",
> > +		mhuv3_str[mhu->frame]);
> > +
> > +	return 0;
> > +}
> > +
> > +static mhuv3_extension_initializer mhuv3_extension_init[MAX_EXT] = {
> > +	mhuv3_dbe_init,
> > +	mhuv3_fce_init,
> > +	mhuv3_fe_init,
> > +};
> > +
> > +static int mhuv3_initialize_channels(struct device *dev, struct mhuv3 *mhu)
> > +{
> > +	int i, ret = 0;
> > +	struct mbox_controller *mbox = &mhu->mbox;
> > +
> > +	mbox->chans = devm_kcalloc(dev, mhu->tot_chans,
> > +				   sizeof(*mbox->chans), GFP_KERNEL);
> > +	if (!mbox->chans)
> > +		return -ENOMEM;
> > +
> > +	for (i = FIRST_EXT; i < MAX_EXT && !ret; i++)
> Why this dance with FIRST_EXT if it is always 0?  Cleaner to just use 0.
> 

Ok, I'll do...I was thinking was more clear to specify what was the
start instead of a plain 0....but indeed is apparent from the context.

> > +		if (mhu->ext[i])
> > +			ret = mhu->ext[i]->channels_init(mhu);
> > +
> > +	return ret;
> > +}
> > +
> > +static struct mbox_chan *mhuv3_mbox_of_xlate(struct mbox_controller *mbox,
> > +					     const struct of_phandle_args *pa)
> > +{
> > +	unsigned int type, channel, param;
> > +	struct mhuv3 *mhu = mhu_from_mbox(mbox);
> > +
> > +	if (pa->args_count != MHUV3_MBOX_CELLS)
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	type = pa->args[MHUV3_MBOX_CELL_TYPE];
> > +	if (type >= MAX_EXT)
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	channel = pa->args[MHUV3_MBOX_CELL_CHWN];
> > +	param = pa->args[MHUV3_MBOX_CELL_PARAM];
> > +
> > +	return mhu->ext[type]->mbox_of_xlate(mhu, channel, param);
> > +}
> > +
> > +static int mhuv3_frame_init(struct mhuv3 *mhu, void __iomem *regs)
> > +{
> > +	int i, ret = 0;
> > +	struct device *dev = mhu->mbox.dev;
> > +
> > +	mhu->ctrl = regs;
> > +	mhu->frame = readl_relaxed_bitfield(&mhu->ctrl->blk_id, blk_id);
> > +	if (mhu->frame > MBX_FRAME) {
> > +		dev_err(dev, "Invalid Frame type- %d\n", mhu->frame);
> > +		return -EINVAL;
> dev_err_probe() etc (see later)
> 

Yes, indeed. I've just posted a series to use dev_err_probe on the SCMI
stack and then missed completely here...my bad. I'll do.

> > +	}
> > +
> > +	mhu->major = readl_relaxed_bitfield(&mhu->ctrl->aidr, arch_major_rev);
> > +	mhu->minor = readl_relaxed_bitfield(&mhu->ctrl->aidr, arch_minor_rev);
> > +	if (mhu->major != MHUV3_MAJOR_VERSION) {
> > +		dev_warn(dev, "Unsupported MHU %s block - major:%d  minor:%d\n",
> > +			 mhuv3_str[mhu->frame], mhu->major, mhu->minor);
> 
> You are treating it as an error, so why only a warning?
> 

Right.

> > +		return -EINVAL;
> > +	}
> > +	mhu->auto_op_full = !!readl_relaxed_bitfield(&mhu->ctrl->feat_spt1,
> > +						     auto_op_spt);
> > +	/* Request the PBX/MBX to remain operational */
> > +	if (mhu->auto_op_full)
> > +		writel_relaxed_bitfield(0x1, &mhu->ctrl->ctrl, op_req);
> > +
> > +	dev_dbg(dev, "Found MHU %s block - major:%d  minor:%d\n",
> > +		mhuv3_str[mhu->frame], mhu->major, mhu->minor);
> > +
> > +	if (mhu->frame == PBX_FRAME)
> > +		mhu->pbx = regs;
> > +	else
> > +		mhu->mbx = regs;
> > +
> > +	for (i = FIRST_EXT; i < MAX_EXT && !ret; i++)
> > +		ret = mhuv3_extension_init[i](mhu);
> 
> Only dbe_init() returns any errors, so if I ready this correctly you always
> eat that error. 

Yes, I'll fix the logic.

> 
> > +
> > +	return ret;
> > +}
> > +
> > +static irqreturn_t mhuv3_pbx_comb_interrupt(int irq, void *arg)
> > +{
> > +	int ret = IRQ_NONE;
> > +	unsigned int i, found = 0;
> > +	struct mhuv3 *mhu = arg;
> > +	struct device *dev = mhu->mbox.dev;
> > +	struct mbox_chan *chan;
> > +
> > +	for (i = FIRST_EXT; i < MAX_EXT; i++) {
> > +		/* FCE does not participate to the PBX combined */
> > +		if (i == FCE_EXT || !mhu->ext[i])
> > +			continue;
> > +
> > +		chan = mhu->ext[i]->chan_from_comb_irq_get(mhu);
> > +		if (!IS_ERR(chan)) {
> 
> 		if (IS_ERR(chan))
> 			continue;
> 
> will reduce indent and give more readable code.
>

Ok.
 
> > +			struct mhuv3_mbox_chan_priv *priv = chan->con_priv;
> > +
> > +			found++;
> > +			if (chan->cl) {
> > +				mbox_chan_txdone(chan, 0);
> > +				ret = IRQ_HANDLED;
> > +			} else {
> > +				dev_warn(dev,
> > +					 "TX Ack on UNBOUND channel (%u)\n",
> > +					 priv->ch_idx);
> > +			}
> > +		}
> > +	}
> > +
> > +	if (!found)
> > +		dev_warn_once(dev, "Failed to find channel for the TX interrupt\n");
> > +
> > +	return ret;
> > +}
> > +
> > +static irqreturn_t mhuv3_mbx_comb_interrupt(int irq, void *arg)
> > +{
> > +	int ret = IRQ_NONE;
> > +	unsigned int i, found = 0;
> > +	struct mhuv3 *mhu = arg;
> > +	struct device *dev = mhu->mbox.dev;
> > +	struct mbox_chan *chan;
> > +
> > +	for (i = FIRST_EXT; i < MAX_EXT; i++) {
> > +		if (!mhu->ext[i])
> > +			continue;
> > +
> > +		/* Process any extension which could be source of the IRQ */
> > +		chan = mhu->ext[i]->chan_from_comb_irq_get(mhu);
> > +		if (!IS_ERR(chan)) {
> 
> 		if (IS_ERR(chan))
> 			continue;
> 
> is going to be easier to read.
> 

ok.

> > +			void *data = NULL;
> > +			struct mhuv3_mbox_chan_priv *priv = chan->con_priv;
> > +
> > +			found++;
> > +			/* Read and acknowledge optional in-band LE data first. */
> > +			if (priv->ops->read_data)
> > +				data = priv->ops->read_data(mhu, chan);
> > +
> > +			if (chan->cl && !IS_ERR(data)) {
> > +				mbox_chan_received_data(chan, data);
> > +				ret = IRQ_HANDLED;
> > +			} else if (!chan->cl) {
> > +				dev_warn(dev,
> > +					 "RX Data on UNBOUND channel (%u)\n",
> > +					 priv->ch_idx);
> > +			} else {
> > +				dev_err(dev, "Failed to read data: %lu\n",
> > +					PTR_ERR(data));
> > +			}
> 
> I'd be tempted to factor out this code block into another function as I think
> that will allow you to deal with the errors more directly.
> 

I will give a go at reworking.

> > +
> > +			if (!IS_ERR(data))
> > +				kfree(data);
> > +
> > +			/*
> > +			 * Acknowledge transfer after any possible optional
> > +			 * out-of-band data has also been retrieved via
> > +			 * mbox_chan_received_data().
> > +			 */
> > +			if (priv->ops->rx_complete)
> > +				priv->ops->rx_complete(mhu, chan);
> > +		}
> > +	}
> > +
> > +	if (!found)
> > +		dev_warn_once(dev, "Failed to find channel for the RX interrupt\n");
> > +
> > +	return ret;
> > +}
> > +
> > +static int mhuv3_setup_pbx(struct mhuv3 *mhu)
> > +{
> > +	struct device *dev = mhu->mbox.dev;
> > +
> > +	mhu->mbox.ops = &mhuv3_sender_ops;
> > +
> > +	if (mhu->cmb_irq > 0) {
> > +		int ret;
> > +
> > +		ret = devm_request_threaded_irq(dev, mhu->cmb_irq, NULL,
> > +						mhuv3_pbx_comb_interrupt,
> > +						IRQF_ONESHOT, "mhuv3-pbx", mhu);
> > +		if (!ret) {
> > +			int i;
> > +
> > +			mhu->mbox.txdone_irq = true;
> > +			mhu->mbox.txdone_poll = false;
> > +
> > +			for (i = FIRST_EXT; i < MAX_EXT; i++)
> > +				if (mhu->ext[i])
> > +					mhu->ext[i]->combined_irq_setup(mhu);
> > +
> > +			dev_dbg(dev, "MHUv3 PBX IRQs initialized.\n");
> > +
> > +			return 0;
> > +		}
> > +
> > +		dev_err(dev, "Failed to request PBX IRQ - ret:%d", ret);
> 
> If an irq was provided and it failed, I'd just return an error, not muddle on.
> Broken system.  If it's not an 'error' then don't use dev_err()
> 
> Papering over this leads to an odd code flow with if (!ret) so it would
> be nice not to bother unless there is a strong reason to carry on.

Well, the only reason is that when the Tx-Ack interrupt fails somehow to
be setup (or is not provided even though the spec mandates it), the
mailbox can work anyway fine, maybe on degraded performance...so here I was
trying to be kind and carry-on best-effort with a few warnings...since
I already bumped into a system where the Tx-Ack was supposedly present BUT
the wire was NOT ... but indeed better to be noisy and bailout so to have
the thing fixed early on when it happens...I'll revisit

> 
> 
> > +	}
> > +
> > +	dev_info(dev, "Using PBX in Tx polling mode.\n");
> 
> That's noisy.  dev_dbg() perhaps?
> 

Ok, I was trying to be noisy indeed since operating without Tx-Ack can
be limiting in some circumstances and is a sort of anomaly given the
spec would expect the PBX combined interrupt to be provided (but the
mailboxes can work...)

> > +	mhu->mbox.txdone_irq = false;
> > +	mhu->mbox.txdone_poll = true;
> > +	mhu->mbox.txpoll_period = 1;
> > +
> > +	return 0;
> > +}
> > +
> > +static int mhuv3_setup_mbx(struct mhuv3 *mhu)
> > +{
> > +	int ret, i;
> > +	struct device *dev = mhu->mbox.dev;
> > +
> > +	mhu->mbox.ops = &mhuv3_receiver_ops;
> > +
> > +	if (mhu->cmb_irq <= 0) {
> > +		dev_err(dev, "Missing MBX combined IRQ !\n");
> 		return dev_err_probe()
> here as I think it's only called form init.  Sure you might not
> need the deferred handling it provides but it still leads to
> cleaner code and no one has to think about whether deferal might
> happen or not.
> 

Yes I'll switch to dev_err_probe where appropriate.


> > +		return -EINVAL;
> > +	}
> > +
> > +	ret = devm_request_threaded_irq(dev, mhu->cmb_irq, NULL,
> > +					mhuv3_mbx_comb_interrupt, IRQF_ONESHOT,
> > +					"mhuv3-mbx", mhu);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to request MBX IRQ - ret:%d\n", ret);
> > +		return ret;
> 
> 		return dev_err_probe()

Ditto.

> 
> > +	}
> > +
> > +	for (i = FIRST_EXT; i < MAX_EXT; i++)
> > +		if (mhu->ext[i])
> > +			mhu->ext[i]->combined_irq_setup(mhu);
> > +
> > +	dev_dbg(dev, "MHUv3 MBX IRQs initialized.\n");
> > +
> > +	return ret;
> > +}
> > +
> > +static int mhuv3_irqs_init(struct mhuv3 *mhu, struct platform_device *pdev)
> > +{
> > +	int ret;
> > +
> > +	dev_dbg(mhu->mbox.dev, "Initializing %s block.\n", mhuv3_str[mhu->frame]);
> > +
> > +	if (mhu->frame == PBX_FRAME) {
> > +		mhu->cmb_irq = platform_get_irq_byname_optional(pdev, "combined");
> > +		ret = mhuv3_setup_pbx(mhu);
> 
> 		return early is both shorter and easier to follow if people
> are looking at particular paths through the function.

Ok.

> 
> > +	} else {
> > +		mhu->cmb_irq = platform_get_irq_byname(pdev, "combined");
> > +		ret = mhuv3_setup_mbx(mhu);
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static int mhuv3_probe(struct platform_device *pdev)
> > +{
> > +	int ret;
> > +	struct mhuv3 *mhu;
> > +	void __iomem *regs;
> > +	struct device *dev = &pdev->dev;
> > +
> > +	mhu = devm_kzalloc(dev, sizeof(*mhu), GFP_KERNEL);
> > +	if (!mhu)
> > +		return -ENOMEM;
> > +
> > +	regs = devm_platform_ioremap_resource(pdev, 0);
> > +	if (IS_ERR(regs))
> > +		return PTR_ERR(regs);
> > +
> > +	mhu->mbox.dev = dev;
> > +	ret = mhuv3_frame_init(mhu, regs);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = mhuv3_irqs_init(mhu, pdev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	mhu->mbox.of_xlate = mhuv3_mbox_of_xlate;
> > +	ret = mhuv3_initialize_channels(dev, mhu);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = devm_mbox_controller_register(dev, &mhu->mbox);
> > +	if (ret)
> > +		dev_err(dev, "failed to register ARM MHUv3 driver %d\n", ret);
> 
> Use dev_err_probe() to get a few things for free in probe time error messages message.
> 		return dev_err_probe(dev, reg, "failed to register ARM HMUv3 driver\n");

Ditto.

> 
> 	return 0;
> > +
> > +	platform_set_drvdata(pdev, mhu);
> 
> With all devm as suggested below, can I think drop this.
> 
Ok.

> > +
> > +	return ret;
> > +}
> > +
> > +static int mhuv3_remove(struct platform_device *pdev)
> > +{
> > +	struct mhuv3 *mhu = platform_get_drvdata(pdev);
> > +
> > +	if (mhu->auto_op_full)
> > +		writel_relaxed_bitfield(0x0, &mhu->ctrl->ctrl, op_req);
> > +
> 
> From a quick glance probably better to use a
> devm_add_action_or_reset() so that this is turned off at
> equivalent place in remove() path as where it is turned on in _init()
> 
> Only register the callback if auto_op_full()
> 
> Mixing and matching devm_ and calls in remove is a path to weird
> races and corner cases so better to go all in on devm handling.

Ok, I'll switch to devm_ fully and drop remove() all along.

Thanks again for the review.
Cristian

