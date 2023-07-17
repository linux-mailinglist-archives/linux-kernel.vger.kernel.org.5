Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3DCF755E52
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 10:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjGQITU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 04:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjGQITS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 04:19:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B145C12D
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 01:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689581910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5oKLzfrsSLv/Zgptunhw/dKFqbaz2Af8FNAHqmnvOmE=;
        b=NA1LwfHNM6Q/UiWnTNBIbwSB04e6XNh48Iz8J6w2ZtWbBsKjmM+D/W2+ZdsLj9/Yy8Njjq
        boFUAcRgvw3U+pWgwuSC89qLA1PxprvcpXwdECail88wyrlCrVgymSzHSXk5JUrRsIoXIl
        50yuawA8nxkobJj9OIEcqB1wT/jE3uM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-ilVX9vrGPjeI3oAAo7O87A-1; Mon, 17 Jul 2023 04:18:29 -0400
X-MC-Unique: ilVX9vrGPjeI3oAAo7O87A-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-994320959f4so239621166b.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 01:18:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689581908; x=1692173908;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5oKLzfrsSLv/Zgptunhw/dKFqbaz2Af8FNAHqmnvOmE=;
        b=LN4MvWiHCB9nfX/vf0RYV8liWU7fyKpo3I5jV9/U/Yw81lUoenqjZbpnC6EQf+0Ub0
         Zt+8VAwZL2hRLW/BNUfi1UzZ74byGbS5IiF2xi7O2AiJXdHMuJ0sbC4eY9m07QWCtAUG
         s4Tkl32ABGyaVexjnjFsgtB/5VyBvdiUoMUwa7FuU+wpEHcC4JgKv7Q8GsP3IsD0h12a
         YOc22chB+f0Ic207TEP4fm3JdxFTraYo25J/cBExakOcmzOyK8dzMCxKl69juNJApQjJ
         IS/IU/zryT6+jJbxSPsqDcxtVw6jD3iO/VdbKQ45nfmew80uQb9Su77ze6QGMg2fnWJ5
         HPZg==
X-Gm-Message-State: ABy/qLbDHXEzfsycz5crZfhag2dMrb/fF9z0u5KIT6ToFZCQpcXtmluj
        FdRGcwP8xlILHuRNDpapXfExEUg/tuOyYqG84IQJtL8ahX/pqGYk8weo1JLKkejNMmWTyhFSSFX
        z/y6MeoFtKpNr/zXQo3N2GGsf
X-Received: by 2002:a17:907:601f:b0:98c:cc3c:194e with SMTP id fs31-20020a170907601f00b0098ccc3c194emr9443230ejc.52.1689581908258;
        Mon, 17 Jul 2023 01:18:28 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG1mTeHX4Zof5URvAjo1aYjMIK4C6L9rnGZ7vudb8wb1OpUK3HcvKW39ydP44SSIDeaSDhJ6Q==
X-Received: by 2002:a17:907:601f:b0:98c:cc3c:194e with SMTP id fs31-20020a170907601f00b0098ccc3c194emr9443213ejc.52.1689581908006;
        Mon, 17 Jul 2023 01:18:28 -0700 (PDT)
Received: from [192.168.0.224] (host-79-51-12-181.retail.telecomitalia.it. [79.51.12.181])
        by smtp.gmail.com with ESMTPSA id j22-20020a170906411600b00993159ce075sm8772560ejk.210.2023.07.17.01.18.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 01:18:27 -0700 (PDT)
Message-ID: <aaf2d1d9-fba8-eae9-83a5-b13dbc206cd2@redhat.com>
Date:   Mon, 17 Jul 2023 10:16:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] sched: Fixed typo in comment
To:     Chin Yik Ming <yikming2222@gmail.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org
References: <20230717064952.2804-1-yikming2222@gmail.com>
Content-Language: en-US, pt-BR, it-IT
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <20230717064952.2804-1-yikming2222@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/17/23 08:49, Chin Yik Ming wrote:
> task_struct's state member is prefixed by "__"
> 
> Signed-off-by: Chin Yik Ming <yikming2222@gmail.com>

Reviewed-by: Daniel Bristot de Oliveira <bristot@kernel.org>

-- Daniel

