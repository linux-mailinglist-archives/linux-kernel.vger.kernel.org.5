Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5200F769311
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 12:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjGaK12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 06:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbjGaK1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 06:27:24 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789E6E3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 03:27:22 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0ED246606FCD;
        Mon, 31 Jul 2023 11:27:20 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690799240;
        bh=0EMt158aYdiMc6fR078Q1lPbm9qwFR7NqEIcGeRMPp8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=M6liAR1t331PIgPv5Jfnfc7l3w/Mxqzgh9SkfQTviYfRec/qGwATNyb4HbNjvz6Nn
         dJV5bmo6PXe//0QIjBbfHVNLHPQuEEE4ZK+LTOrJ44uXnZjpuM20WYObHn/bhFEmNB
         2Q2vi3rHd1B7Oft9U3no49ft1hnU+Zx8gEofzos+w2H8h23Sx8w9HynUO11GboS+LN
         HQDW6/Ik7hmISCrK4O7WWDQOBnP9UDg4Pd8HqcljRjQ7CAiSbwhdfkqpZ46OXJV//S
         deTmBA/iKR12dPeZUkTt3O2AhTIGN235vd54p1aspCSJNe4LDwGLBJXnOqHfGtkNfG
         BtFdTcXzoCvxw==
Message-ID: <4e0bcb82-03f7-66de-19ec-9cc23f95ddad@collabora.com>
Date:   Mon, 31 Jul 2023 12:27:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH RESEND v6 09/11] drm/mediatek: gamma: Add support for
 12-bit LUT and MT8195
To:     Alexandre Mergnat <amergnat@baylibre.com>, chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, wenst@chromium.org,
        kernel@collabora.com, ehristev@collabora.com,
        "Jason-JH . Lin" <jason-jh.lin@mediatek.com>
References: <20230727094633.22505-1-angelogioacchino.delregno@collabora.com>
 <20230727094633.22505-10-angelogioacchino.delregno@collabora.com>
 <ec66e067-642e-1512-3e4b-b51065ccc75d@baylibre.com>
 <8b9769f3-8a7c-3607-ca9a-09443cfbc9d9@collabora.com>
 <0b9d62d0-5958-2b0f-03d7-9e91e026c33d@baylibre.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <0b9d62d0-5958-2b0f-03d7-9e91e026c33d@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 28/07/23 14:58, Alexandre Mergnat ha scritto:
> Hi Angelo
> 
> On 27/07/2023 15:06, AngeloGioacchino Del Regno wrote:
>>>> +/* For 10 bit LUT layout, R/G/B are in the same register */
>>>>   #define DISP_GAMMA_LUT_10BIT_R            GENMASK(29, 20)
>>>>   #define DISP_GAMMA_LUT_10BIT_G            GENMASK(19, 10)
>>>>   #define DISP_GAMMA_LUT_10BIT_B            GENMASK(9, 0)
>>>> +/* For 12 bit LUT layout, R/G are in LUT, B is in LUT1 */
>>>
>>> As I understood from the application processor registers (v0.4), R/G are in LUT, 
>>> B is in LUT1 for 10bit and 12bit for MT8195. Can you check please to be sure ?
>>>
>>
>> That's right, but here I'm implying that 10-bit LUT is only for older SoCs, and
>> all of them have got the same register layout with one LUT register for R, G, B,
>> while all the new SoCs, which have got 12-bits LUT support, have got the new
>> register layout with two LUT registers (and multiple banks).
>> Infact, the MT8195 SoC was added here with 12-bits LUT support only (as the LUT
>> parameters extraction is easily handled by the drm_color_lut_extract() function).
>>
>> The alternative would've been to add two compatibles, like
>> "mediatek,mt8195-disp-gamma-10bits" and "mediatek,mt8195-disp-gamma-12bits",
>> or a boolean property like "mediatek,lut-12bits" which would appear literally
>> everywhere starting from a certain point in time (since there's no reason to
>> use 10-bits LUT on MT8195, that starts now!).
>>
>> Even then, consider the complication in code, where mtk_gamma_set_common()
>> would have to handle:
>> - 10-bits, layout A
>> - 10-bits, layout B -> but fallback to layout A if this is AAL
>> - 12-bits layout
>>
>> is_aal = !(gamma && gamma->data);
>>
>> for_each_bank()
>> {
>>      if (num_lut_banks > 1) write_num_bank();
>>
>>      for (i = 0; i < lut_bank_size; i++) {
>>          .......
>>
>>          if (!lut_diff || (i % 2 == 0)) {
>>              if (lut_bits == 12 || (lut_bits == 10 && layout_b)) {
>>                  ... setup word[0],[1] ...
>>              } else if (layout_b && !is_aal) {
>>                  ...setup word[0],[1]...
>>              } else {
>>                  ...setup word[0]
>>              }
>>          } else {
>>               ^^^ almost repeat the same ^^^
>>          }
>>          writel(word[0], (...));
>>          if (lut_bits == 12 || (lut_bits == 10 && layout_b) && !is_aal)
>>              writel(word[i] (....));
>>      }
>> }
>>
>> probe() {
>>      if (of_property_read_bool(dev->of_node, "mediatek,lut-12bits") ||
>>          data->supports_only_12bits)
>>          priv->lut_bits = 12;
>>      else
>>          priv->lut_bits = 10;
>> }
>>
>> ...at least, that's the implementation that I would do to solve your concern,
>> which isn't *too bad*, but still, a big question arises here...
>>
>>
>> Why should we care about supporting *both* 10-bit and 12-bit Gamma LUTs on
>> the *same* SoC?
>>
>>
>> A 12-bit LUT gives us more precision and there's no penalty if we want to
>> convert a 10-bit LUT to a 12-bits one, as we're simply "ignoring" the value
>> of two bits per component (no expensive calculation involved)...
>>
>> Is there anything that I'm underestimating here?
> 
> Thanks for you explanation !
> I think your choice is not bad, but it's not clear that MT8195 10 bit LUT isn't 
> supported at all.
> So, IMHO, the first solution is to support it like you explained it above, and the 
> second solution is to add comment somewhere to clarify that driver doesn't support 
> 10 bit LUT if the SoC is able to use 12 bit LUT, like MT8195 10 bit.
> 
> Is that relevant ? :D
> 

Even though the same as whhat I'm doing here was already done before, as the
current 10-bits LUT support ignores 9-bits LUT support, I can add a comment to
the code:

/*
  * SoCs supporting 12-bits LUTs are using a new register layout that does
  * always support (by HW) both 12-bits and 10-bits LUT but, on those, we
  * ignore the support for 10-bits in this driver and always use 12-bits.
  *
  * Summarizing:
  * - SoC HW support 9/10-bits LUT only
  *   - Old register layout
  *     - 10-bits LUT supported
  *     - 9-bits LUT not supported
  * - SoC HW support both 10/12bits LUT
  *   - New register layout
  *    - 12-bits LUT supported
  *    - 10-its LUT not supported
  */

Where the SoCs supporting 9-bits and 10-bits: mt6795, 8173, 8192,others and
12-bits are 8195, 8186, others.. of course.

Would that work for you?

Regards,
Angelo
