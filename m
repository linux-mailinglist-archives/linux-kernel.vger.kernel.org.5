Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 347B778C219
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 12:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235051AbjH2KNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 06:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234156AbjH2KMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 06:12:54 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1F8B4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 03:12:48 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-412178dde5bso17821731cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 03:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1693303967; x=1693908767;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f3U7w7Dxv0aMNSqkqHyETmyZKkPYclhc4evSzr8ifFs=;
        b=jdlvcZWEok692A9iQ9+qmfAm3k7qCYat9eF1bXFp3fEQ+4j25X4UOa7oJP6BGevYIM
         it0nLAmGWroG/4wZUyOlR7ogL5WkoFEk4vuZNL4b3ngHPYHOK5U/Vfzb5adgNhGT2NHy
         5DVMaVD2QTIBsx0biBk05aVWebB9F9JrXsaMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693303967; x=1693908767;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f3U7w7Dxv0aMNSqkqHyETmyZKkPYclhc4evSzr8ifFs=;
        b=I0p8+RgyJWA1s/5bPWewS7ETdsVGx1vyzNopgFZ1ftMx9HkdxNdYnddQ4gVxO0BW0K
         j5G4O7kf/ekl+KGd2qMw3go/op51ECNeN1NXLX2ZUEUSzaiXTRo2DYEuuTMenkd9RAYw
         mK8oc6ifrHZhdyHJHEzIeiUoa3Ag+dVD8qUXUHMIYNmlqlUBgIG2ETHCkcaEL2wELOpX
         dkXG+ibXywSIlKQejxxgssfZi5txGwiE/xLng8Yva220hW4StKiXJSEO3We4FaO4PWoo
         YZD/EYWrDp4uTZaUUXjAc1/qWOhNHuB5AOxz2ZNYC5P2GqBlROlPpQFcwrj7qfjD6FnK
         +NQw==
X-Gm-Message-State: AOJu0YwGKW9vxWpil2TuhUWCv0+XrAvfIsmn27NkiuhvzPfVKKvc6w5L
        pg7SK+TDYrdTGZyqOUtUA3J19g==
X-Google-Smtp-Source: AGHT+IEVqgTNW06+UI1f1xfAQUCG/TUuimalKVqTc0ftOoXMoENg9h8R5usdIgj3KVXW0k9a4L1CRA==
X-Received: by 2002:a05:622a:1013:b0:403:f42a:95bc with SMTP id d19-20020a05622a101300b00403f42a95bcmr32558121qte.28.1693303967586;
        Tue, 29 Aug 2023 03:12:47 -0700 (PDT)
Received: from smtpclient.apple ([45.88.220.64])
        by smtp.gmail.com with ESMTPSA id kc5-20020a05622a44c500b00411f7da6e1bsm2888781qtb.60.2023.08.29.03.12.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 03:12:46 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] rcutorture: Traverse possible cpu to set maxcpu in rcu_nocb_toggle()
Date:   Tue, 29 Aug 2023 06:12:35 -0400
Message-Id: <D98FE55B-C379-4C24-B4DD-4E02A1E2AB79@joelfernandes.org>
References: <ZO25SDat3cd6opQ7@lothringen>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Z qiang <qiang.zhang1211@gmail.com>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org
In-Reply-To: <ZO25SDat3cd6opQ7@lothringen>
To:     Frederic Weisbecker <frederic@kernel.org>
X-Mailer: iPhone Mail (20B101)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 29, 2023, at 5:24 AM, Frederic Weisbecker <frederic@kernel.org> wro=
te:
>=20
> =EF=BB=BFOn Mon, Aug 28, 2023 at 05:51:09PM -0400, Joel Fernandes wrote:
>> I think the issue is the loop later in the function does
>> not try to toggle cpus that came online too late.
>>=20
>> So it does not test offloading on all CPUs just because max got updated t=
oo
>> late.
>=20
> Right, and therefore for_each_possible_cpu() or for_each_present_cpu()
> should be fine to iterate since it's ok to try to toggle an offline CPU.

Ah I see what you mean, sounds good.

>=20
>>=20
>> One fix could be to periodically check in the loop if a new cpu at maxcpu=
 + 1
>> ever got onlined. If it did, update the maxcpu.
>=20
> Is it worth the complication though?

Probably not and so your suggestion sounds fine.

Thanks!

 - Joel


>=20
> Thanks.
>=20
>>=20
>> Thanks.
>>=20
>>=20
>>>=20
>>> Thanks.
