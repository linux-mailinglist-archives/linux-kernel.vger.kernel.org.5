Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F8C7B078F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 17:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbjI0PCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 11:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbjI0PCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:02:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72528CD6;
        Wed, 27 Sep 2023 08:02:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A96E6C433C7;
        Wed, 27 Sep 2023 15:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695826933;
        bh=r8NJqB+Eskoh9K1MkrQnG5srH7gWNZFeblzEWCKg2ek=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dF1x9v6FR31R1fdTryZ3/4xKYsKnyb5iunoYG4CVwJ5i098D+gDiHo3u6uZUhAdvJ
         cTpvMuST3Lli3Py9ecOWHMbwtisIuicQUhgBopTU+JRcNTLvwb6W4B3QU/feEoCv9p
         GnMUkhO9AnInoB761J+f21N+VBhkhCReHrcZGtBTEcnK+THjD7jl6/aIGC15LTh6aZ
         spJ6J/R4Em4Un+nyAsTkdvEN+QY/OeXE4e9ASC1RrsIUHff6I8dH1C9kghGG5Zpmku
         5+zl8WSbP69JzRtaq457YiCW3w25jxluEN+Se+Y920RqssBM9dBkqYzDkcPamot36G
         UgZPe2sXHMamw==
Date:   Wed, 27 Sep 2023 17:02:09 +0200
From:   Mark Brown <broonie@kernel.org>
To:     Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     mathias.nyman@intel.com, gregkh@linuxfoundation.org,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, srinivas.kandagatla@linaro.org,
        bgoswami@quicinc.com, Thinh.Nguyen@synopsys.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v7 29/33] ASoC: qcom: qdsp6: Add SND kcontrol for
 fetching offload status
Message-ID: <ZRRD8eFZugh/+dex@finisterre.sirena.org.uk>
References: <20230921214843.18450-1-quic_wcheng@quicinc.com>
 <20230921214843.18450-30-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2qid1YG4vVF/Hdr6"
Content-Disposition: inline
In-Reply-To: <20230921214843.18450-30-quic_wcheng@quicinc.com>
X-Cookie: Save energy:  Drive a smaller shell.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2qid1YG4vVF/Hdr6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 21, 2023 at 02:48:39PM -0700, Wesley Cheng wrote:

> Add a kcontrol to the platform sound card to fetch the current offload
> status.  This can allow for userspace to ensure/check which USB SND
> resources are actually busy versus having to attempt opening the USB SND
> devices, which will result in an error if offloading is active.

> +static int q6usb_prepare(struct snd_pcm_substream *substream,
> +               struct snd_soc_dai *dai)
> +{
> +       struct q6usb_port_data *data =3D dev_get_drvdata(dai->dev);
> +=20
> +       mutex_lock(&data->mutex);
> +       data->status[data->sel_card_idx].running =3D true;
> +       mutex_unlock(&data->mutex);

These updates of running should really have a snd_ctl_notify() so that
UIs can know to update when the value changes while they're open.

> +static int q6usb_mixer_get_offload_status(struct snd_kcontrol *kcontrol,
> +				   struct snd_ctl_elem_value *ucontrol)
> +{

> +	running =3D q6usb_find_running(data);
> +	if (running < 0) {
> +		card_idx =3D -1;
> +		pcm_idx =3D -1;
> +	} else {
> +		card_idx =3D running;
> +		pcm_idx =3D data->status[running].pcm_index;
> +	}
> +
> +	ucontrol->value.integer.value[0] =3D card_idx;
> +	ucontrol->value.integer.value[1] =3D pcm_idx;

This feels a bit messy but I'm not sure what we'd do that's better so
unless someone else has better ideas let's go with this.  Possibly we
should standardise this as a new control type for joining cards up so at
least if there's further needs for this we can use the same solution?

--2qid1YG4vVF/Hdr6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUUQ+0ACgkQJNaLcl1U
h9Bd4gf/SmW7ryUa29e71/V9HuX7Jew2MdnRQDuXz6STFyi1WM6tcjFJSRGg0qG4
+JqN2fHT/gRP7Bflr/Bn+DVjr4ms8Rp0KS98kfKk4gHHoJr+Y7yDROhNJ3gMUxP7
V7c/ZtQoP32PyNcM8K2x48fbOm1PBkZS8ch/BRzaIV0Jswv9aArfeP30ApjrIZb+
tG7/Qrgeyao2F7u4J4wd74HaFKdp0HXk3csDcXlZ8bqit2/zx5de1UBVnmHzRaVS
g0dubyNXyFQVTJRYfAphnLkmg7T7Cknn17SxaEmlkfMTKoS6kXB+t04e3NsyvuvM
Tt1rVGB3hzwIPa1u8VT5/HgysV7eFQ==
=JgtR
-----END PGP SIGNATURE-----

--2qid1YG4vVF/Hdr6--
