Return-Path: <linux-kernel+bounces-121089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D86F88E23A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD1F61C2A921
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A8E16E885;
	Wed, 27 Mar 2024 12:20:50 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0334E16E87B;
	Wed, 27 Mar 2024 12:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542049; cv=none; b=g43wlYWsVa41qP6oixOzfaHofFO8dcswXvdcHns4bWuoh5jj9db4Fs3qe5bbu96SY20R9nB6369ZcoBrETuzLCbOtO8vrHOtR72byNxOQTwa3VWpz9KQRjIzhu14KvlQQxWre6W98OxGyJYKCYKxY5Z0mP4u9qvHavnWgCWEhkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542049; c=relaxed/simple;
	bh=LRqKiwGQKW7zOHKPcIfgNzsz56fEdVAyupC8tElZlts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qgq3Jkm/ol3l6iZYTvNjPTm0jfHCGI4DfBepHpgje4rZfkEmoBiTeH0+BbDeGSrWZ/G7xRFg3dfHSE8XwqkRaPJLmNhHlBFNPdq1weeeL1aM+V+uEFlZfWZJ5QmSb7U8gFUp35GMZcseULLRi6gyzkQQn/woEec88oXbTbW8KU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8463E2F4;
	Wed, 27 Mar 2024 05:21:21 -0700 (PDT)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 934533F694;
	Wed, 27 Mar 2024 05:20:45 -0700 (PDT)
Date: Wed, 27 Mar 2024 12:20:39 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	Sudeep Holla <sudeep.holla@arm.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>,
	Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Subject: Re: [PATCH v6 3/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Message-ID: <ZgQPF_jT07hudU1H@pluto>
References: <20240323-pinctrl-scmi-v6-0-a895243257c0@nxp.com>
 <20240323-pinctrl-scmi-v6-3-a895243257c0@nxp.com>
 <4879ad5d-165c-4118-81f7-8f6348a5a5d4@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4879ad5d-165c-4118-81f7-8f6348a5a5d4@moroto.mountain>

On Wed, Mar 27, 2024 at 01:46:11PM +0300, Dan Carpenter wrote:
> Looks really nice.  Just a few small comments below.
> 

Hi,

I aa having a look at this today (and try to retest it), just a quick remark
down below...

> On Sat, Mar 23, 2024 at 08:15:16PM +0800, Peng Fan (OSS) wrote:
> > +
> > +struct scmi_msg_func_set {
> > +	__le32 identifier;
> > +	__le32 function_id;
> > +	__le32 flags;
> > +};
> 
> This scmi_msg_func_set struct is unused.  Delete.
> 
> > +static void
> > +iter_pinctrl_settings_get_prepare_message(void *message, u32 desc_index,
> > +					  const void *priv)
> > +{
> > +	struct scmi_msg_settings_get *msg = message;
> > +	const struct scmi_settings_get_ipriv *p = priv;
> > +	u32 attributes;
> > +
> > +	attributes = FIELD_PREP(CONFIG_FLAG_MASK, p->flag) |
> > +		     FIELD_PREP(SELECTOR_MASK, p->type);
> > +
> > +	if (p->flag == 1)
> > +		attributes |= FIELD_PREP(SKIP_CONFIGS_MASK, desc_index);
> > +	else if (!p->flag)
> 
> This is a nit-pick but could you change these !p->flag conditions to
> p->flag == 0?  It's a number zero, not a bool.
> 
> > +		attributes |= FIELD_PREP(CONFIG_TYPE_MASK, p->config_types[0]);
> > +
> > +	msg->attributes = cpu_to_le32(attributes);
> > +	msg->identifier = cpu_to_le32(p->selector);
> > +}
> > +
> > +static int
> > +iter_pinctrl_settings_get_update_state(struct scmi_iterator_state *st,
> > +				       const void *response, void *priv)
> > +{
> > +	const struct scmi_resp_settings_get *r = response;
> > +	struct scmi_settings_get_ipriv *p = priv;
> > +
> > +	if (p->flag == 1) {
> > +		st->num_returned = le32_get_bits(r->num_configs, GENMASK(7, 0));
> > +		st->num_remaining = le32_get_bits(r->num_configs,
> > +						  GENMASK(31, 24));
> > +	} else {
> > +		st->num_returned = 1;
> > +		st->num_remaining = 0;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int
> > +iter_pinctrl_settings_get_process_response(const struct scmi_protocol_handle *ph,
> > +				       const void *response,
> > +				       struct scmi_iterator_state *st,
> > +				       void *priv)
> > +{
> > +	const struct scmi_resp_settings_get *r = response;
> > +	struct scmi_settings_get_ipriv *p = priv;
> > +
> > +	if (!p->flag) {
> 
> 
> if (p->flag == 0) {
> 
> > +		if (p->config_types[0] !=
> > +		    le32_get_bits(r->configs[st->loop_idx * 2], GENMASK(7, 0)))
> > +			return -EINVAL;
> > +	} else if (p->flag == 1) {
> > +		p->config_types[st->desc_index + st->loop_idx] =
> > +			le32_get_bits(r->configs[st->loop_idx * 2],
> > +				      GENMASK(7, 0));
> > +	} else if (p->flag == 2) {
> > +		return 0;
> > +	}
> > +
> > +	p->config_values[st->desc_index + st->loop_idx] =
> > +		le32_to_cpu(r->configs[st->loop_idx * 2 + 1]);
> > +
> > +	return 0;
> > +}
> > +
> > +static int
> > +scmi_pinctrl_settings_get(const struct scmi_protocol_handle *ph, u32 selector,
> > +			  enum scmi_pinctrl_selector_type type,
> > +			  enum scmi_pinctrl_conf_type config_type,
> > +			  u32 *config_value)
> > +{
> > +	int ret;
> > +	void *iter;
> > +	struct scmi_iterator_ops ops = {
> > +		.prepare_message = iter_pinctrl_settings_get_prepare_message,
> > +		.update_state = iter_pinctrl_settings_get_update_state,
> > +		.process_response = iter_pinctrl_settings_get_process_response,
> > +	};
> > +	struct scmi_settings_get_ipriv ipriv = {
> > +		.selector = selector,
> > +		.type = type,
> > +		.flag = 0,
> 
> ->flag should be 0-2.
> 

The .flag in this priv structure is for 'configuring' the iterators in
the SCMI core to parse a multi-part response, so (looking at how the
iterators functs are implemented above) setting it here to zero
means issuing a SETTINGS_GET with attributes.config_flag[19:18] == 0,
that in turn means requesting just a single config_value to be read...

..if you want to support the other 'flavours' of SETTINGS_GET
(multiple configs & selected_func) you will have to extend the signature
of this function to optionally select to readback multiple configs (and to
allow the return of such multiple config_values) and/or optionally request
to return the selected function....

..or maybe add distinct wrapper protocol_ops just for these flavours...

Anyway, till now in this series it was avoided to add such 'flavours'
support (e.g. for multiple configs) since there are no users for the
multi-config and function selected in the pinctrl driver...so no way to test..

Will the Linux GPIO driver need these ? Should we delay anyway the
addition of the support of such variants of SETTING_GET for when a real
user like GPIO driveer appears ?

..anyway @Peng please add a comment somewhere explaining how p->flag is
used to configure the type of SETTINGS_GET

Thanks,
Cristian

