Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3CF2798ED2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 21:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344139AbjIHTMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 15:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236695AbjIHTMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 15:12:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE94F19C;
        Fri,  8 Sep 2023 12:12:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A503C433AB;
        Fri,  8 Sep 2023 18:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694198641;
        bh=hTakPB9y2sP+KFVIRgK+FzqnkIyWJ1W8m+mc/mWg3pM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mA2DCny7oDWvISNAOQ2sKcgoSL/JNlwal1YaYzyH6M0RauIWK8F/iissT4T4yZiaY
         ZSJvtecmlUChP7HAhom1yNsOYl40fJoIqDG0WxK7MUTbGE7DPFhTVvrWTaF6DmggcH
         /Sy19E3Q6kggvQ5B7qiJPnxbBNr63JkyPDqQRJ3CAG12sXiefngO49EV7qDbu4sdNq
         vHJbUdVf2fu4ftjFH60MEWy9CcPsQdB02BSMU6JbwgzwMx0Lx8KDCh7SLRLcF/HqzS
         TXt7mvWbGT4w/shmHN/ZnklbU/T7zoYPoycKmFnUfGRarC6pwQ0ZulxMEGBLACvGpR
         Y1cBIGYBi8tYg==
Date:   Fri, 8 Sep 2023 19:44:25 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Andreas Klinger <ak@it-klinger.de>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: pressure: Support ROHM BU1390
Message-ID: <20230908194425.24f1554e@jic23-huawei>
In-Reply-To: <eba53e24-ea01-6c38-27ee-27c3d10aa73f@gmail.com>
References: <cover.1694001462.git.mazziesaccount@gmail.com>
        <08f7085ba1af2fae21c942f6c20a94c237df53ba.1694001462.git.mazziesaccount@gmail.com>
        <ZPifWlRvX5hLFPvG@smile.fi.intel.com>
        <4d8e2873-49bc-8314-ee16-dd327a92898d@gmail.com>
        <ZPnW38eO6by1NjIr@smile.fi.intel.com>
        <eba53e24-ea01-6c38-27ee-27c3d10aa73f@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Sep 2023 09:12:51 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 9/7/23 16:57, Andy Shevchenko wrote:
> > On Thu, Sep 07, 2023 at 08:57:17AM +0300, Matti Vaittinen wrote:  
> >> On 9/6/23 18:48, Andy Shevchenko wrote:  
> >>> On Wed, Sep 06, 2023 at 03:37:48PM +0300, Matti Vaittinen wrote:  
> > 
> > ...
> >   
> >>>> +struct bm1390_data {
> >>>> +	int64_t timestamp, old_timestamp;  
> >>>
> >>> Out of a sudden int64_t instead of u64?  
> >>
> >> Judging the iio_push_to_buffers_with_timestamp() and iio_get_time_ns(), IIO
> >> operates with signed timestamps. One being s64, the other int64_t.
> >>  
> >>>> +	struct iio_trigger *trig;
> >>>> +	struct regmap *regmap;
> >>>> +	struct device *dev;
> >>>> +	struct bm1390_data_buf buf;
> >>>> +	int irq;
> >>>> +	unsigned int state;
> >>>> +	bool trigger_enabled;  
> >>>  
> >>>> +	u8 watermark;  
> >>>
> >>> Or u8 instead of uint8_t?  
> >>
> >> So, uint8_t is preferred? I don't really care all that much which of these
> >> to use - which may even show up as a lack of consistency... I think I did
> >> use uint8_t when I learned about it - but at some point someone somewhere
> >> asked me to use u8 instead.. This somewhere might have been u-boot though...
> >>
> >> So, are you Suggesting I should replace u8 with uint8_t? Can do if it
> >> matters.  
> > 
> > Consistency matters, since I do not know the intention behind, I suggest use
> > either, but be consistent in the entire code. However, uXX are specific Linux
> > kernel internal types and some maintainers prefer them. Also you may grep for
> > the frequency of intXX_t vs. sXX or their unsigned counterparts.
> >   
> >>>> +	/* Prevent accessing sensor during FIFO read sequence */
> >>>> +	struct mutex mutex;
> >>>> +};  
> > 
> > ...
> >   
> >>>> +static int bm1390_read_temp(struct bm1390_data *data, int *temp)
> >>>> +{
> >>>> +	u8 temp_reg[2] __aligned(2);  
> >>>
> >>> Why?! Just use proper bitwise type.  
> >>
> >> What is the proper bitwise type in this case?
> >>
> >> I'll explain my reasoning:
> >> What we really have in hardware (BM1390) and read from it is 8bit registers.
> >> This is u8 to me. And as we read two consecutive registers, we use u8
> >> arr[2]. In my eyes it describes the data perfectly well, right?  
> > 
> > Two different registers?! Why bulk is used in that case?
> > To me looks like you are reading 16-bit (or one that fits in 16-bit) register
> > in BE notation.  
> 
> As I wrote, it is two 8 bit registers at consecutive addresses. And this 
> is what u8 arr[2]; also says.
> 
> Bulk read is mandatory as HW has a special feature of preventing the 
> update of these registers when a read is ongoing. If we do two reads we 
> risk of getting one of the registers updated between the accesses - 
> resulting incorrect value.

Far as the kernel is concerned this is a __be16 and we use a bulk read to
fill it from two registers.  If the use showed them having unrelated uses
then it would be fair to handle it as an array of u8.

> 
> >   
> >>>> +	__be16 *temp_raw;
> >>>> +	int ret;
> >>>> +	s16 val;
> >>>> +	bool negative;
> >>>> +
> >>>> +	ret = regmap_bulk_read(data->regmap, BM1390_REG_TEMP_HI, &temp_reg,
> >>>> +			       sizeof(temp_reg));
> >>>> +	if (ret)
> >>>> +		return ret;
> >>>> +
> >>>> +	if (temp_reg[0] & 0x80)
> >>>> +		negative = true;
> >>>> +	else
> >>>> +		negative = false;  
> >>>  
> >>>> +	temp_raw = (__be16 *)&temp_reg[0];  
> >>>
> >>> Heck no. Make temp_reg be properly typed.  
> >>
> >> As I explained above, to me it seems ur arr[2} is _the_ proper type to
> >> represent data we read from the device.
> >>
> >> What we need to do is to convert the 16bits of data to an integer we can
> >> give to the rest of the system. And, we happen to know how to 'manipulate'
> >> the data to get it in format of understandable integer. As we have these 16
> >> bits in memory, aligned to 2 byte boundary - why shouldn't we just
> >> 'manipulate' the data and say - here we have your integer, please be my
> >> guest and use it?  
> > 
> > Because it smell like a hack and is a hack here.
> > Either it's a single BE16 register, or it's two different registers that by
> > very unknown reason you are reading in a bulk.  
> 
> It is two registers. The bulk read might warrant a comment - although I 
> believe this is nothing unusual. If it is a hack or not is an opinion. 
> To me it looks like a code that explicitly shows what data is and how it 
> is being handled. It does what it is supposed to do and shows it in all 
> dirty details.

Read it directly into a __be16

> 
> Still, I am open to suggestions but I'd prefer seeing a real improvement 
> instead of claiming that the hardware is something it is not (eg, having 
> 16bit registers or should be read by individual accesses).
> 
> The code in this form is no
> > go.
> >   
> >> Well, I am keen to learn the 'correct bitwise type' you talk about - can you
> >> please explain me what this correct type for two 8bit integers is? Maybe I
> >> can improve.  
> > 
> > If the registers are not of the same nature the bulk access is wrong.
> > Use one by one reads.  
> 
> Of same nature? As I said, there is 2 8bit registers at consecutive 
> addresses. They have no other 'nature' as far as I can tell.
> 
> Data in these registers in not in standard format - it needs to be 
> manipulated to make it an ordinary integer. The code shows this very 
> clearly by not reading it in any standard integer.

I'm not convinced it does.  All support arch are 2s complement.
be16_to_cpu() is fine for what you have unless I'm missing something.
If it weren't we would have signed versions of those macros.


> 
> > ...
> >   
> >>>> +static int bm1390_pressure_read(struct bm1390_data *data, u32 *pressure)
> >>>> +{
> >>>> +	int ret;
> >>>> +	u8 raw[3];
> >>>> +
> >>>> +	ret = regmap_bulk_read(data->regmap, BM1390_REG_PRESSURE_BASE,
> >>>> +			       &raw[0], sizeof(raw));  
> > 
> > &raw[0] --> raw
> >   
> >>>> +	if (ret < 0)
> >>>> +		return ret;
> >>>> +
> >>>> +	*pressure = (u32)(raw[2] >> 2 | raw[1] << 6 | raw[0] << 14);  
> > 
> > This, btw, looks like le24, but I'm puzzled with right shift.
> > I need to read datasheet carefully to understand this.  
> 
> It's not just le24. We, again, have data placed in registers so that it 
> needs some suffling. The data-sheet does decent job explaining it 
> though. AFAIR, there was a 'gap' in bits so it needed some more suffling 
> to sift the bits so that they're consecutive. I think this indeed is 
> something that needs to be looked up from data-sheet to understand why 
> this play with bits is done.


These cases are harder to argue.  I'm fine with either approach for this one
as a get_unaligned_le24() >> 2 would give same answer unless I'm also missing
something but it isn't that obvious.

Jonathan
