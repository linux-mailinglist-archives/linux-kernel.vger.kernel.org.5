Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A081782675
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 11:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234455AbjHUJot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 05:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjHUJos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 05:44:48 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AEC5A1;
        Mon, 21 Aug 2023 02:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=d9AC3Y3wKvLhTCxarPAnq2BCxnL4Toqn/q0Gu3hZcq0=;
        t=1692611087; x=1693820687; b=pce1bbcqzid6XJBsSrkqYv/RaOqYOpF/w4Kfw+fB1fv6kM+
        UeGMP5K2y7zfNElskru7tulx+03dzI35U65rtGZbQuVWMFeaxJs2Y58Pbcbr2x7cLUG6CozHXjO3Y
        URpdVZzUhXnbjQ/uXx2S56oD/25Wzw89AOHUBylrEcsdYOAp9TyOLNG4Xc8EJvWxLRF1jVWOF8fPJ
        ZGCBzmqnkYWVNW+9O4ec7a7FVzDwhRkRPE4MNvFt+rp6MlmrJUnXqqH9QqtJmb2bHpFh1RQOZSd0a
        BbokVvvEfOuVkGYAXzsr+FLDAqX6k0M/j7dy0bBZ+1r/5EzbN9/10LkASrDN8FaQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qY1SZ-002xnF-2J;
        Mon, 21 Aug 2023 11:44:31 +0200
Message-ID: <e167e97797a90d3d6ea09840ac909325537d6034.camel@sipsolutions.net>
Subject: Re: [V9 4/9] wifi: mac80211: Add support for WBRF features
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Evan Quan <evan.quan@amd.com>, gregkh@linuxfoundation.org,
        rafael@kernel.org, lenb@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        alexander.deucher@amd.com, andrew@lunn.ch, rdunlap@infradead.org,
        quic_jjohnson@quicinc.com, horms@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        Mario Limonciello <mario.limonciello@amd.com>
Date:   Mon, 21 Aug 2023 11:44:29 +0200
In-Reply-To: <20230818032619.3341234-5-evan.quan@amd.com>
References: <20230818032619.3341234-1-evan.quan@amd.com>
         <20230818032619.3341234-5-evan.quan@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-08-18 at 11:26 +0800, Evan Quan wrote:
> To support the WBRF mechanism, Wifi adapters utilized in the system must
> register the frequencies in use(or unregister those frequencies no longer
> used) via the dedicated calls. So that, other drivers responding to the
> frequencies can take proper actions to mitigate possible interference.
>=20
> Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> Co-developed-by: Evan Quan <evan.quan@amd.com>
> Signed-off-by: Evan Quan <evan.quan@amd.com>

From WiFi POV, this looks _almost_ fine to me.

> +static void wbrf_get_ranges_from_chandef(struct cfg80211_chan_def *chand=
ef,
> +					 struct wbrf_ranges_in *ranges_in)
> +{
> +	u64 start_freq1, end_freq1;
> +	u64 start_freq2, end_freq2;
> +	int bandwidth;
> +
> +	bandwidth =3D nl80211_chan_width_to_mhz(chandef->width);
> +
> +	get_chan_freq_boundary(chandef->center_freq1,
> +			       bandwidth,
> +			       &start_freq1,
> +			       &end_freq1);
> +
> +	ranges_in->band_list[0].start =3D start_freq1;
> +	ranges_in->band_list[0].end =3D end_freq1;
> +
> +	if (chandef->width =3D=3D NL80211_CHAN_WIDTH_80P80) {
> +		get_chan_freq_boundary(chandef->center_freq2,
> +				       bandwidth,
> +				       &start_freq2,
> +				       &end_freq2);
> +
> +		ranges_in->band_list[1].start =3D start_freq2;
> +		ranges_in->band_list[1].end =3D end_freq2;
> +	}
> +}

This has to setup ranges_in->num_of_ranges, no?
(Also no real good reason for num_of_ranges to be a u64, btw, since it
can only go up to 11)

With that fixed, you can add

Reviewed-by: Johannes Berg <johannes@sipsolutions.net>

johannes

