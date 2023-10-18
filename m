Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED2B87CE4AE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjJRRdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbjJRRcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:32:39 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1CE526AF
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 10:29:17 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c509d5ab43so80220541fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 10:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697650156; x=1698254956; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c9mW/8DEleFixbtMa99KMZOBUTSC7Ptb45fTVDigBn4=;
        b=rFxt4hl1rtPMb9vUgrsZ4CqZsqGmc7ybmV62HsiM8J0psEP2aB0ZEaMW9LwwkM0CX5
         k+ai4wvKaE2n3fl7ZBp42+djp+Uk2nfzEAGbwL66ewp5mRw/zkRByvnP8M7XWTiFu8Ak
         pn/kYIpzzvWCbw+cUJT5+hzQ5kN8od3dKOnHZ7n6TWHYK3QhsYkiHWvo0FihDIkciKzr
         QElZjBpX5XrgdZ/kCcLfhcqlA2bWPNvW/i6QHe9LCvjfZDEGz8OFpYDoYSIlL2yHJOEz
         badNr/n2xp/AvE9OrAjL8MEBYKy3zUKbSLXZjK3Om63gweV1lrWhyHbnFjS2WXfSCoqc
         FsUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697650156; x=1698254956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c9mW/8DEleFixbtMa99KMZOBUTSC7Ptb45fTVDigBn4=;
        b=nZgPepTWx1w0X4d0U/CgCfciXA1rnYe0N3CkNCADlWgVSliXgkPt5NHupo/Q+Xwv+d
         Rb1osfpnyrhB1kSItGpEWa668DNSFeSYqwQIfb8STSxboBf7lfQJtXRfWQUBL3iSprUo
         GNPp9nCx32y9P8lYmR7wi6vOA2pGQiFMbRQh3dE9bAfFjoGm85TJzvdHgXa8W/uEvvUx
         SsMxlA2XGiWTyjQPPADvA6nD6ehBd20ty7Molt1TEW7Erb7Xzw5UcywYHIhhrWeuoIz2
         xvYOMKL1wCFg62bF1E45wVOtqL2cydFLdlQw2e4LdaMLsgzsjQUcMfHcyXAewofnoxMD
         SybA==
X-Gm-Message-State: AOJu0YzxxZ1PZYZPUpRfT5w8VjNsYd9tbaJ+uVvXImSyNh8ojYQycFVR
        XV1vlvCo7nsDYU5cOmlZKmFIHScLc2YlqjUcZbdSvA==
X-Google-Smtp-Source: AGHT+IEKxwcNhG7R9mpe5DzutveDAX4kbTZ+kqkFoiHb0qfB741C7dwpjxdZ3dHNWy9wDmKFREgYKiMobD1lxW4k5X8=
X-Received: by 2002:a2e:880d:0:b0:2c0:2ef8:9716 with SMTP id
 x13-20020a2e880d000000b002c02ef89716mr3912537ljh.1.1697650155617; Wed, 18 Oct
 2023 10:29:15 -0700 (PDT)
MIME-Version: 1.0
References: <20231017131456.2053396-1-cleger@rivosinc.com> <20231017131456.2053396-15-cleger@rivosinc.com>
In-Reply-To: <20231017131456.2053396-15-cleger@rivosinc.com>
From:   Evan Green <evan@rivosinc.com>
Date:   Wed, 18 Oct 2023 10:28:39 -0700
Message-ID: <CALs-Hss8g8+CFd9T1QAPj0eksJmjBi6jL8O1hT2R37PN31WG3w@mail.gmail.com>
Subject: Re: [PATCH v2 14/19] riscv: add ISA extension parsing for Zvfh[min]
To:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor@kernel.org>,
        Samuel Ortiz <sameo@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 6:15=E2=80=AFAM Cl=C3=A9ment L=C3=A9ger <cleger@riv=
osinc.com> wrote:
>
> Add parsing for Zvfh[min] ISA extension[1] which were ratified in
> june 2023 around commit e2ccd0548d6c ("Remove draft warnings from
> Zvfh[min]") in riscv-v-spec[2].
>
> Link: https://drive.google.com/file/d/1_Yt60HGAf1r1hx7JnsIptw0sqkBd9BQ8/v=
iew [1]
> Link: https://github.com/riscv/riscv-v-spec/commits/e2ccd0548d6c [2]
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>

Reviewed-by: Evan Green <evan@rivosinc.com>
