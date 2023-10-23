Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC1A7D41A7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 23:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbjJWV3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 17:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjJWV3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 17:29:16 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707A097;
        Mon, 23 Oct 2023 14:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=ZhjxUrT7ActbgiD9MJ/0J4Uyj55UgMInYRT8SxjqdOs=; b=LNh34dCRqWx9h3oSXcJ5/QXkAf
        ybmB7vgbVZJ+eIP0hwZIsQaNuzsAmJS1OFLuo3ll3Le0uUIW1zkgLnUb7rbZf3TfUvVzEnDRfDfEc
        EwsKbLHs7ZGXVR7QwhN6NGRZfkYsLmG0AnxsMd4QOTtcK8qtxcAkhRqc1BvHW3KeYnP0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qv2Tq-00011F-7W; Mon, 23 Oct 2023 23:28:58 +0200
Date:   Mon, 23 Oct 2023 23:28:58 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        corbet@lwn.net, steen.hegelund@microchip.com,
        rdunlap@infradead.org, horms@kernel.org, casper.casan@gmail.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        horatiu.vultur@microchip.com, Woojung.Huh@microchip.com,
        Nicolas.Ferre@microchip.com, UNGLinuxDriver@microchip.com,
        Thorsten.Kummermehr@microchip.com
Subject: Re: [PATCH net-next v2 1/9] net: ethernet: implement OPEN Alliance
 control transaction interface
Message-ID: <c51d9660-d6c3-4202-9fc6-b9add06b64ce@lunn.ch>
References: <20231023154649.45931-1-Parthiban.Veerasooran@microchip.com>
 <20231023154649.45931-2-Parthiban.Veerasooran@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023154649.45931-2-Parthiban.Veerasooran@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static void oa_tc6_prepare_ctrl_buf(struct oa_tc6 *tc6, u32 addr, u32 val[],
> +				    u8 len, bool wnr, u8 *buf, bool prote)

One of the comments i made last time was that wnr is not obvious. I
assume it means write-not-read. So why not just write? Since it a
boolean, i assume war is never needed, so !wnr cal always be
considered rnw.

And prote could well be protect, the two extra characters make it a
lot more obvious. Or better still.

> +{
> +	u32 hdr;
> +
> +	/* Prepare the control header with the required details */
> +	hdr = FIELD_PREP(CTRL_HDR_DNC, 0) |
> +	      FIELD_PREP(CTRL_HDR_WNR, wnr) |
> +	      FIELD_PREP(CTRL_HDR_AID, 0) |
> +	      FIELD_PREP(CTRL_HDR_MMS, addr >> 16) |
> +	      FIELD_PREP(CTRL_HDR_ADDR, addr) |
> +	      FIELD_PREP(CTRL_HDR_LEN, len - 1);
> +	hdr |= FIELD_PREP(CTRL_HDR_P, oa_tc6_get_parity(hdr));
> +	*(__be32 *)buf = cpu_to_be32(hdr);
> +
> +	if (wnr) {
> +		for (u8 i = 0; i < len; i++) {
> +			u16 pos;
> +
> +			if (!prote) {

nitpick, but please use positive logic. Do the protected case first.

	 Andrew

