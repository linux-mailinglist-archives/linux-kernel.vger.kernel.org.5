Return-Path: <linux-kernel+bounces-27411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D93D682EF9D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 14:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 033401C233FD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 13:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E021BDC2;
	Tue, 16 Jan 2024 13:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="m8HblPnD"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040D31BC47;
	Tue, 16 Jan 2024 13:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ej944qWFIi9COYJbBb09o9QKP8cZyiOYwsc2orhfIt4=; b=m8HblPnDO5qXLUMnufSJwanb4X
	F3UWBnF9h5JHQPP6F2CVRMfVGd1oUv+3UTePhOAYP6ijcN/Ososc7qvjsV96EJyuybBb41vV4RN/W
	YTsYGrpry9JlBgTaTzCcGdl9oYsjsebtXRIcsqCtq6b61DufTx9LVzNB+id/fg2RFOug=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rPjKO-005JiB-Id; Tue, 16 Jan 2024 14:18:04 +0100
Date: Tue, 16 Jan 2024 14:18:04 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
	Dent Project <dentproject@linuxfoundation.org>
Subject: Re: [PATCH net-next v2 8/8] net: pse-pd: Add PD692x0 PSE controller
 driver
Message-ID: <64f30166-58cc-409d-ba5b-9ea3fb8ead88@lunn.ch>
References: <20231201-feature_poe-v2-0-56d8cac607fa@bootlin.com>
 <20231201-feature_poe-v2-8-56d8cac607fa@bootlin.com>
 <639c5222-043f-4e27-9efa-ce2a1d73eaba@lunn.ch>
 <20240116104949.12708cd5@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116104949.12708cd5@kmaincent-XPS-13-7390>

> 
> > > +static int pd692x0_fw_get_next_line(const u8 *data,
> > > +				    char *line, size_t size)
> > > +{
> > > +	size_t line_size;
> > > +	int i;
> > > +
> > > +	line_size = min_t(size_t, size, (size_t)PD692X0_FW_LINE_MAX_SZ);
> > > +
> > > +	memset(line, 0, PD692X0_FW_LINE_MAX_SZ);
> > > +	for (i = 0; i < line_size - 1; i++) {
> > > +		if (*data == '\r' && *(data + 1) == '\n') {
> > > +			line[i] = '\r';
> > > +			line[i + 1] = '\n';
> > > +			return i + 2;
> > > +		}  
> > 
> > Does the Vendor Documentation indicate Windoze line endings will
> > always be used? Motorola SREC allow both Windows or rest of the world
> > line endings to be used. 
> 
> All the firmware lines end with "\r\n" but indeed it is not specifically
> written that the firmware content would follow this. IMHO it is implicit that
> it would be the case as all i2c messages use this line termination.
> Do you prefer that I add support to the world line endings possibility? 

No need, just hack an SREC file, and test the parser does not explode
with an opps, and you get an sensible error message about the firmware
being corrupt. I would not be too surprised if there are some mail
systems still out there which might convert the line ending.

> > > +static enum fw_upload_err pd692x0_fw_poll_complete(struct fw_upload *fwl)
> > > +{
> > > +	struct pd692x0_priv *priv = fwl->dd_handle;
> > > +	const struct i2c_client *client = priv->client;
> > > +	struct pd692x0_msg_ver ver;
> > > +	int ret;
> > > +
> > > +	priv->fw_state = PD692X0_FW_COMPLETE;
> > > +
> > > +	ret = pd692x0_fw_reset(client);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ver = pd692x0_get_sw_version(priv);
> > > +	if (ver.maj_sw_ver != PD692X0_FW_MAJ_VER) {  
> > 
> > That is probably too strong a condition. You need to allow firmware
> > upgrades, etc. Does it need to be an exact match, or would < be
> > enough?
> 
> The major version is not compatible with the last one, the i2c messages
> content changed. I supposed a change in major version would imply a change in
> the i2c messages content and would need a driver update that's why I used this
> strong condition.

Do you know the next major version will change the message contents?
Is this documented somewhere? If so add a comment. Otherwise, i would
allow higher major versions. When the vendor breaks backwards
compatibility, its going to need code changes anyway, and at that
point the test can be made more strict.

We try to make vendors not make firmware ABI breaking changes, and we
have pushed back against a number of vendors who do. So i think its
best we assume they won't break the ABI.

      Andrew

