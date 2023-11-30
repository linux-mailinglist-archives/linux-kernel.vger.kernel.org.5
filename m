Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A267FF36F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 16:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346276AbjK3PUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 10:20:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346240AbjK3PUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 10:20:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C471410EF
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 07:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701357639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dEqkJxwjlfqEUZLoeifhFNRmLYsQ9sgPgHYM3n7xUho=;
        b=fGiyAnq0vl7oPNCFFGqTJIpR6TEKT7xXS3Ou0fYpmkBnnVnR/R9l32THF1zTalnpUy8pX+
        16KIDFli/8X9fm6AsICFCz6SutVX4MFR+2rDuNDtW1KlGU5OvkIdL0fZ4PcLAPgR32ZBt3
        OUc1Mds5GjMrDtUy+UiJsTrqTHo2Sc4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-qRh3R-P0Pjuj9jbFMitXOQ-1; Thu, 30 Nov 2023 10:20:37 -0500
X-MC-Unique: qRh3R-P0Pjuj9jbFMitXOQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40a3d918dc1so1519575e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 07:20:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701357636; x=1701962436;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dEqkJxwjlfqEUZLoeifhFNRmLYsQ9sgPgHYM3n7xUho=;
        b=NGkNHt27LxQ1zgLentFISvIiX/IqLnDZ3fSZ3bH0Zrxr0B5o9BDjz4Z1gUvcoMzlyr
         hHa+irmiFrcHxfmBmVfoziXVYnmnuwS/i5QM233DyiaylNfNMU0rNnwmdJ0RadnFh+Kj
         zpeljk3dsEZNtGY+1aoWGvnYuXrLq21WQo1ndtqAnQgGKml2y1U05ZGBQ1ac/rJ1BzV4
         HEGP/xB5isShoYY6XE3wpWNgeV1iS9Cew1Yh402zs61z8yqyK79zn1uZr4u0JwqHV2L9
         z94XfDEi88mL1YQ8yfQw5elM3wQGahZp6tnrUaWNC0MkFchCCVMNcPR/M9zswCmTIRLL
         eGIw==
X-Gm-Message-State: AOJu0YyjiF+KDry7ow6TroNz8OsVui2+niruOBK7ojBQlVXg0UMDkhee
        JG5qyrEmgRWwfp80nN0mrZq6yTnN50daVIgaXVzVgA67M4ORszE1usgkWKIfpnEt3eF1va0vBPB
        zjBK+ygK4mn+aPO73pmFIsIWe
X-Received: by 2002:a05:600c:8512:b0:405:358c:ba75 with SMTP id gw18-20020a05600c851200b00405358cba75mr15223896wmb.0.1701357636290;
        Thu, 30 Nov 2023 07:20:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmWmZDOiZtkqddOsdMjnFnx0anMvXkNnD8AcLel/BSwwmSEX8SLaio0xywMh1dMKaV6S35xQ==
X-Received: by 2002:a05:600c:8512:b0:405:358c:ba75 with SMTP id gw18-20020a05600c851200b00405358cba75mr15223881wmb.0.1701357635879;
        Thu, 30 Nov 2023 07:20:35 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-118-234.dyn.eolo.it. [146.241.118.234])
        by smtp.gmail.com with ESMTPSA id u2-20020a05600c138200b00405d9a950a2sm6036725wmf.28.2023.11.30.07.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 07:20:35 -0800 (PST)
Message-ID: <182382de40ab8f129829ceb3fa3f71608bfa65fb.camel@redhat.com>
Subject: Re: [GIT PULL] Networking for v6.7-rc4
From:   Paolo Abeni <pabeni@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 30 Nov 2023 16:20:34 +0100
In-Reply-To: <20231130125638.726279-1-pabeni@redhat.com>
References: <20231130125638.726279-1-pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-11-30 at 13:56 +0100, Paolo Abeni wrote:
> We just received a report regarding the WiFi/debugfs fixes below possibly
> causing some dmesg noise - trying to register multiple times the same ent=
ry.

Jakub noted that such report is on a kernel that predates the changes
in this PR, so you can ignore the above.

Sorry for the noise,

Paolo

