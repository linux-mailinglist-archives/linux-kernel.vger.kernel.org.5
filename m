Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B467CB2A2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 20:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbjJPSjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 14:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJPSjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 14:39:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A10AC
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 11:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697481503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zs+lHskTeTS1TcsvMpv41AYJj/qLk+4rSlBCHgXCWvc=;
        b=BH6FHG6U6OT6OJZCvEjwQt19G28QAjytgpvbtstjYhrUYwRgHT925tYFPckVKT5mnCgs+z
        1ZHYqAvZdQNOrwIKkIgxsRKSinVOlaWtIKAeQR3w/fO4r+vDR8FP8RY76+ASptXkLb9Sft
        zIlAjuSuuhrPPBgBs4iZmwnlhQ1m/ws=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-aAt5vhfgOFqU8e-ufXDixA-1; Mon, 16 Oct 2023 14:38:21 -0400
X-MC-Unique: aAt5vhfgOFqU8e-ufXDixA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9a5d86705e4so352439366b.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 11:38:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697481500; x=1698086300;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zs+lHskTeTS1TcsvMpv41AYJj/qLk+4rSlBCHgXCWvc=;
        b=Wcgt6/j5PToIQWbprogL0nZkDquGJag4m4zpMspa0gtHMfSieYNgg1kAMsHdlB0Ele
         44zH+Lg2tYqa9i1w18vbdt3bO1ckxd6haouX43yk0hoXToLwFYDvtDAoTUuBkXq/UC1Z
         RRVL5MG6AIkTzUSqFOW2uorLXvZFmwHE8Mi92wF9ebCZRWiqkRulTTU9Wi8HRWZhjqIw
         juPegr9t3GnmPycmxEhGF7O3BscaNvzJ6RMbcXV2MMdUZ+JdaZHCqEYqjV4zSRXO56DR
         10yKa82gUwJ5nwV5ogQpJoAteEgwh9gCm3S1Q9hmLXEi970IF0MVmEY9+/zGpqu7xX4X
         kaDg==
X-Gm-Message-State: AOJu0YxBppXDtum02n+p5nhEuwY9PTsDaQdzREzrNwXv09gdoc3C4Atz
        AAwJqW1YcZI/L3ARhmNKtnaOT/ySbbUnZ9Yw4Yo3z7uBk0sP6gDecSubOEZgAc5glEu2gK8VXcI
        G+w2uqpl98lEjq2IHeuHsKndh
X-Received: by 2002:a17:907:3e21:b0:9c3:bd63:4245 with SMTP id hp33-20020a1709073e2100b009c3bd634245mr4522961ejc.47.1697481500733;
        Mon, 16 Oct 2023 11:38:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHH+jj7O1f0tpsiiEeDbkTbIvsIwBY4dqV1bDh+UI49K/oX5NoNQC7BVLjRgvfyHSwPJIczZw==
X-Received: by 2002:a17:907:3e21:b0:9c3:bd63:4245 with SMTP id hp33-20020a1709073e2100b009c3bd634245mr4522945ejc.47.1697481500498;
        Mon, 16 Oct 2023 11:38:20 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id nc30-20020a1709071c1e00b009b65a834dd6sm4476471ejc.215.2023.10.16.11.38.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 11:38:19 -0700 (PDT)
Message-ID: <1c5b051e-8ee2-6f61-dc18-3c6f75b428d5@redhat.com>
Date:   Mon, 16 Oct 2023 20:38:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] ACPI: resource: Do IRQ override on TongFang GMxXGxx
Content-Language: en-US, nl
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Werner Sembach <wse@tuxedocomputers.com>
Cc:     Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231016160828.373599-1-wse@tuxedocomputers.com>
 <CAJZ5v0itvrL7ijh07kB6i6o0ShCboWhv+09Gzo299DLK+GkH1w@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAJZ5v0itvrL7ijh07kB6i6o0ShCboWhv+09Gzo299DLK+GkH1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/16/23 19:33, Rafael J. Wysocki wrote:
> On Mon, Oct 16, 2023 at 6:08 PM Werner Sembach <wse@tuxedocomputers.com> wrote:
>>
>> The TongFang GMxXGxx/TUXEDO Stellaris/Pollaris Gen5 needs IRQ overriding
>> for the keyboard to work. Adding an entry for this laptop to the
>> override_table makes the internal keyboard functional.
>>
>> v2: Rebase onto linux-next
> 
> Hans, any comments?

No comments, the patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans





> 
>> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
>> Cc: <stable@vger.kernel.org>
>> ---
>>  drivers/acpi/resource.c | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
>> index 18f6353c142e..15a3bdbd0755 100644
>> --- a/drivers/acpi/resource.c
>> +++ b/drivers/acpi/resource.c
>> @@ -497,6 +497,18 @@ static const struct dmi_system_id irq1_edge_low_force_override[] = {
>>                         DMI_MATCH(DMI_BOARD_NAME, "GMxRGxx"),
>>                 },
>>         },
>> +       {
>> +               /* TongFang GMxXGxx/TUXEDO Polaris 15 Gen5 AMD */
>> +               .matches = {
>> +                       DMI_MATCH(DMI_BOARD_NAME, "GMxXGxx"),
>> +               },
>> +       },
>> +       {
>> +               /* TongFang GM6XGxX/TUXEDO Stellaris 16 Gen5 AMD */
>> +               .matches = {
>> +                       DMI_MATCH(DMI_BOARD_NAME, "GM6XGxX"),
>> +               },
>> +       },
>>         {
>>                 /* MAINGEAR Vector Pro 2 15 */
>>                 .matches = {
>> --
>> 2.34.1
>>
> 

