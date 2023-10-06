Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 366B17BC002
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 22:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233395AbjJFUJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 16:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233306AbjJFUJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 16:09:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCABC2
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 13:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696622901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lpCwVK4YdUU2xA1XEQ+cf6KoEZIaM/xayFYhSIqPSJg=;
        b=RjmxK7AHFjW4nwuowOI0Lj0SPMyhUfbXQbH1GsCPJ6nMh+FKkrBSw/IjnDjRR2+28hbgXS
        viisnNdWTcfR8JuGYQ314lO7CkR42M67JX+bGAW+N4fN5dAjs5A1j1UCGZevCRgEsc0O/a
        9tAKcSjywQktILV5hUAuZpsS4Ck0HJ0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-6oEEdbQ9Ocy_qL4IJIIq7g-1; Fri, 06 Oct 2023 16:08:10 -0400
X-MC-Unique: 6oEEdbQ9Ocy_qL4IJIIq7g-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-65b23c40cefso23631716d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 13:08:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696622889; x=1697227689;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lpCwVK4YdUU2xA1XEQ+cf6KoEZIaM/xayFYhSIqPSJg=;
        b=XZ8Nj9gO4e4zWxoMozFGQcIwk7qXrJGpRpDmYeI+VZWgKULOEClI27Fuuc6MUyN+vr
         SghP4e4NMz9EHbOsrYlop1VxLTh5HwbxlWfSJW86oVrYTAbneD+IyK8zr1cR1ele96gd
         oUbh7n1yqyVXQqJi2wJVTiRNrMmxqZ+slGJ64JjQW4d45YizaScv3PEIKp95EoItTSb4
         inmtJoOeVB1WBc+L7/IkiKz7jRMcPSRKLBRH1TWhkSP99OW2Tz0ZHZhpGkvbnC3sPnxQ
         bs0bSDEDJ9TpyhS1GnGvDPY7hckztuNWPFoGxih6RUcV/Uy4Md8rAYi9vQ6uiJ5TAfn/
         uBdw==
X-Gm-Message-State: AOJu0YylnQoCdkHtzkEuDI4O5gLaNJqrptewotmh9fAmHDSKAYlONNox
        KkJSNObZnLEVSY9RVcIlkqRePLQ3kQ58XVTlNNNUnf/vVBMbDKdMsPHkpWowMfJc/M9pR1S6t75
        2igEBYJwLUT7Iph1oxy/Vl+8f
X-Received: by 2002:a05:6214:440d:b0:636:afa1:345d with SMTP id oj13-20020a056214440d00b00636afa1345dmr9486284qvb.17.1696622889423;
        Fri, 06 Oct 2023 13:08:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtIR+NwYLWDaMKa7uZ2+P63aN2xD3Bov3ZVMEy/nvU1rz9LawJvySc/NGWRrS0Nqml9Zmq/Q==
X-Received: by 2002:a05:6214:440d:b0:636:afa1:345d with SMTP id oj13-20020a056214440d00b00636afa1345dmr9486265qvb.17.1696622889140;
        Fri, 06 Oct 2023 13:08:09 -0700 (PDT)
Received: from brian-x1 (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id w9-20020a0cb549000000b0065b14fcfca6sm1654528qvd.118.2023.10.06.13.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 13:08:08 -0700 (PDT)
Date:   Fri, 6 Oct 2023 16:08:06 -0400
From:   Brian Masney <bmasney@redhat.com>
To:     Nikunj Kela <quic_nkela@quicinc.com>
Cc:     sudeep.holla@arm.com, cristian.marussi@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: arm: Add new compatible for smc/hvc
 transport for SCMI
Message-ID: <ZSBpJkrsLxly2jTr@brian-x1>
References: <20230718160833.36397-1-quic_nkela@quicinc.com>
 <20231006164206.40710-1-quic_nkela@quicinc.com>
 <20231006164206.40710-2-quic_nkela@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006164206.40710-2-quic_nkela@quicinc.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 09:42:05AM -0700, Nikunj Kela wrote:
> Introduce compatible "qcom,scmi-smc" for SCMI smc/hvc transport channel for
> Qualcomm virtual platforms.
> 
> This compatible mandates populating an additional parameter 'capability-id'
> from the last 8 bytes of the shmem channel.
> 
> Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>

Reviewed-by: Brian Masney <bmasney@redhat.com>

