Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5AF87CC0BF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 12:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343660AbjJQKei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 06:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233570AbjJQKeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 06:34:37 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4059FB0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 03:34:33 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231017103416epoutp02de643da9f7e8ca4b7d1fe16db363e8e4~O3pijko1_0404804048epoutp02M
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 10:34:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231017103416epoutp02de643da9f7e8ca4b7d1fe16db363e8e4~O3pijko1_0404804048epoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1697538856;
        bh=Q4z2iN7Ey/eoTr/LVn1MjXIK4fTsJi+C2xrNopgllbI=;
        h=Date:Subject:Reply-To:From:To:CC:References:From;
        b=clLMKjIKs8TJnVgIeXX4SbwIKqwa9Y4q/FcnitwDE/f/uQKbnCl4MBbMFrulKl6Ya
         Fngfp5G/aCKq/C3kEE4AbKeHbkLD2RXDe6x4RPmJmcS0+WO9n/tzrFV4rl3lEYOdBM
         ZDXmOFzNa5ES46Apuw/SwSYCDNlqfoqJhEYDypfE=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20231017103416epcas5p2cbdda1bd7afd8bf74ab16c58304e3b38~O3piKf92U0963009630epcas5p29;
        Tue, 17 Oct 2023 10:34:16 +0000 (GMT)
X-AuditID: b6c32a4b-39fff700000025c8-d1-652e6328e377
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D3.14.09672.8236E256; Tue, 17 Oct 2023 19:34:16 +0900 (KST)
Date:   Tue, 17 Oct 2023 16:04:15 +0530
Message-ID: <1830198030.734987.1697538855953@mail-kr5-1.mail-kr5.knoxportal-kr-prod-blue.svc.cluster.local>
Mime-Version: 1.0
Subject: [PATCH] input: gpio-keys - optimize wakeup sequence.
Reply-To: abhi1.singh@samsung.com
Sender: Abhishek Kumar Singh <abhi1.singh@samsung.com>
From:   Abhishek Kumar Singh <abhi1.singh@samsung.com>
To:     "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
CC:     "robh@kernel.org" <robh@kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        SRI-N IT Security <sri-n.itsec@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
X-CMS-MailID: 20231017103415epcms5p2f8f5b28a8f5d71055622b82f71b0fc93
Content-Type: multipart/mixed;
        boundary="----=_Part_734986_747581812.1697538855953"
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBKsWRmVeSWpSXmKPExsWy7bCmpq5Gsl6qwZJ7PBaHF71gtLj56Rur
        xeVdc9gs/u/ZwW5x4s8mZgdWj52z7rJ7bFrVyebRt2UVo8fnTXIBLFFcNimpOZllqUX6dglc
        GZsPrWQsOCRe8XD2T/YGxtmiXYycHBICJhJPzy5j62Lk4hAS2M0o8ebMDPYuRg4OFgFViVUz
        uEBqeAWyJZre72UCCfMKCEr83SEMEhYWsJVY+nsFE4gtJKAosWhOBzNE3Exi8913jCDlbEDj
        V2znAQmLCFhLHNjXAbaJWeAKo0Tz1QtMECfwSsxof8oCYUtLbF++lRHCFpW4ufotO4z9/th8
        qLiIROu9s8wQtqDEg5+7GWF6vx+4xQZh10uc+j6BBWSZhEAPo8S8uZ+gFphLnPnVA2W7SNz9
        +wWsmVkgVGL50wMsEDafRO/vJ3DH7ZgHY6tK7D/7jxlm2Y5Jq6CO85D49/QoGyQgAiW+Tl3I
        PIFRdhYiuGYh2QBha0ssW/iaGaSEWUBTYv0ufYiwmsSU/i9sELaTxKeze6BsRYkp3Q/ZFzCy
        r2KUTC0ozk1PLTYtMM5LLdcrTswtLs1L10vOz93ECE4wWt47GB89+KB3iJGJg/EQowpQ+6MN
        qy8wSrHk5eelKonwpgfrpArxpiRWVqUW5ccXleakFh9ilOZgURLnfd06N0VIID2xJDU7NbUg
        tQgmy8TBKdXANCmSX2vzF+f+pJoHv5bPfjtfXvi49YKdOgVZmVv7Yus8o+rkJqbcnVUwp2vN
        kdPPd1xlFLIvEGnfZXUg1n3xgiCGhQnTbDPlCrpUtmzy8Hb8/Njp6KWUlJ/nbHUELj+KcQpZ
        4jW1KJrt77KErOoju9x0fJ1XX16lc1hi/07Z1on3bxmsfXr/IOtJ2ar5kaYu2W7dWt9ElEy/
        TdGXVOWx+yywxebzvBRvKyt+FpOs2qOxMnf5Ot8fOBUsfKp4+9G7Yn/5dsl823vm7t4Hne8a
        5237ztzCm+jy67fsI8nSTyxB6RcnzDI7WZ41PzJRfz7Ttn8ZwuWfxXNmnsv8wL/mbpXr5xMZ
        rO+TNsQJhZ6+qMRSnJFoqMVcVJwIADT5VberAwAA
X-CMS-RootMailID: 20231017103415epcms5p2f8f5b28a8f5d71055622b82f71b0fc93
References: <CGME20231017103415epcms5p2f8f5b28a8f5d71055622b82f71b0fc93@epcms5p2>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_734986_747581812.1697538855953
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dear Mr. Dmitry,

Greetings=21



This patch is related to optimization in input key event driver of Kernel m=
odule.

Suggested change to avoid the many APIs call chain if there is no key press=
 event triggered.



There is a call back function gpio_keys_resume() called for every suspend/r=
esume of the device.

And whenever this function is called, it is reading the status of the key.=
=20

And gpio_keys_resume() API further calls the below chain of API irrespectiv=
e of key press event.



APIs call chain:

static void gpio_keys_report_state(struct gpio_keys_drvdata *ddata)

static void gpio_keys_gpio_report_event(struct gpio_button_data *bdata)

gpiod_get_value_cansleep(bdata->gpiod);

input_event(input, type, *bdata->code, state);

input_sync(input);




Suggested changes to avoid the above APIs call chain if there is no key pre=
ss event triggered.

It will save the device computational resources, power resources and optimi=
ze the suspend/resume time=22


Please help to review the attached patch and integrate in main line kernel =
code.

=C2=A0=0D=0A=0D=0A=0D=0A=0D=0AThanks=20and=20Regards,=0D=0AAbhishek=20Kumar=
=20Singh=0D=0ASr.=20Chief=20Engineer,=20Samsung=20Electronics,=20Noida-India
------=_Part_734986_747581812.1697538855953
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="input_keys_optimized.zip"
Content-Transfer-Encoding: base64

UEsDBBQAAAAIAIZaMlflZigaUAMAACkHAAAaAAAAaW5wdXRfa2V5c19vcHRpbWl6ZWQucGF0Y2it
VF1vIjcUfca/4j5VUJhPCBCyJEHbjRpVraKSPq1WyGN7wM1gz9oeWNrmv/faQ5ImTVdNVQTj8f04
9/j6XK6M3kJ2elIyejpNh5SNxlSUxYTn5ZizshwVo2LMR+U0H06m8KNWsBQ1ZBNI01n4Qp6mGblC
mBnML365vYqmF58vFsVG2o24m+fpD82WGlyXUq03yfJgndji9kbvhTffUONwSZY/X0c/ackv5uQJ
hiZLR8sS/R/UWiohTLKkW9uo9fx9Pl+kHyrBnNFKMot57yhWzWLrC13aNi5mentOvqNOzDz7AWTT
cII8zYeQZbNsMjsZQT89GaZk2RS/It4MPt4sbt9//wluN8IIkBYoMFpVUFB2B2WjmJPYiHUt9epO
HOzKCNtsRbcXogSHUhsidsIcwDa2FoonbQToEtxGABc7yUQMVHHYb4TysejAQo/gLdIApMP6xAjK
8VQh2TrqGvsAhfVjWCDOK2wWN9cIaDDMBDzrM0ghKr0HtqFSeRAfJA3m1Hh0uQscEQZqNFlAZsrF
hGCUbXsQEmfEs5AMdnhjz0rX2riVd4qudaZh7i9ebnacOgrfcr/0/gEjvB2BQvlnQEXjnFarFqdo
cbyDr9bCrXa0asSKUWUrIepu8Efnwd87I1LVzQNmeB+AO9RicASKzpnmuAvsH8PtQbE2Gk0okfVa
oIK574PCV3AaaDiBvw1aaOzgi2aBDFfVKknpl90FZySCGsFjcu1gLzHPUoR5UgqgiJEA9cqgFWCu
bgwTdgC1n6InQ1CUrp3cyt9agBcCRI8gURQRqKRqvkTjeBRnWcIN3ryxSThnggQLTQ1PHi8lZvAH
TKEfPj47g1JW4tgElOkYpLLCeIK22+8NIEfqlWj3UY8QLssSomiNeqbJW2sXb83Au+PiC2RDOi3o
SRwzno3TUwFZmo5HI9+At7MgePT/wOTyEqLxdDLA7vklywEt/8f0AIEO/tFAV8Ic0jOQ8A54q+O6
XVQ7LBZ9/X4PfseEztdnCZG+OWL450f56YxEnQ4K+PkseWPnayPbTuYZ6b+SjETQ3PnbAVs6yKRd
53DMavcBC8G67TY6D7P+APZvyXTu/fMeO+F/r0w43KM6gOTxKIvTeI860nsbZ4T8CVBLAQIUABQA
AAAIAIZaMlflZigaUAMAACkHAAAaAAAAAAAAAAEAIAAAAAAAAABpbnB1dF9rZXlzX29wdGltaXpl
ZC5wYXRjaFBLBQYAAAAAAQABAEgAAACIAwAAAAA=

------=_Part_734986_747581812.1697538855953--
