Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23DBE7D8512
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 16:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345293AbjJZOrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 10:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbjJZOrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 10:47:05 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D01DB9;
        Thu, 26 Oct 2023 07:47:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JnL/DPNz/rtwYb+VTvNVig7lIobB7wXKaMVVPi1AV9qT4k8vvyzOK6pz8OByMuGtxvYlerseP+NbxFoRt0ey8qYY0i86KHG7qF58amnYDA9TyctZL8d/d77Cluja9WJqL3JEBoPdqnsMW+FrhgvjgvA7qsADvcC9rEgjsssaOQiZ9XQtnrf39f7AflyMJ6Aq1HYKC1E4XH6uOB1yiB5ZeQF/SzqDtYRTSY/nFfmykU5msq0+PaWTRs3CVop1AtW1cvv88pMZu2bWKHLeOHqtgL5QO2TBP5rRQN3wt+lkruYK9hISlK61VUAVbg65uLrVfD55/H8j5lKNquiCUBzc+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7nLP7MnO/Y2tClb70JL2Jbn5boyp6Rx8xR2sfWa32j4=;
 b=bM5D0IVn3RH8XJZuKKg1TAgliaAfPoBKA+8v1a67+E/f6LZDtufJaabgGydp4VaNGbZppYMAptCEsfuWFLya67geqBtA0gzAb2+0KUEJyipbslMf3vne8ulVYmNf5iYDYO8fxp715dn6putTRrWHyn5Dvr4EaGBWXkmJG75AorLlKEPUc0T2ZgwPGj4y28mS5moZcMG7JcJTz5kYZAdjclRubEHFk4f1hIgCK1nyF4SGa0Nlc/cjuWiF9FDb1tYR1GjbN+qNJ+jWK2AIxg3/2tF5Eh5iHDXdQYvE2CtYCK5fm37+dJSqc/v/08P686UC7zZ2Jm7Ok8aZZX7uYksJFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7nLP7MnO/Y2tClb70JL2Jbn5boyp6Rx8xR2sfWa32j4=;
 b=iBkHnKMebkDzOj2BY0Aka2tvbiQxPQXdrpaIypOg6QkZPRucF63yGN2hUz2MfdPNKn32DKJCfAeJ5yv5JrmZSY5brTQ0kNv3m4la00mzG2EWvsprZwznoH+4bYgaugEbH+EqBrLkQLxpT8WgRfwBn9+jxzJ2+yLijlNZ221FNwc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by DM3PR08MB9498.namprd08.prod.outlook.com
 (2603:10b6:8:1ad::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Thu, 26 Oct
 2023 14:46:57 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::e73c:270b:75f7:5302]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::e73c:270b:75f7:5302%4]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 14:46:57 +0000
Date:   Thu, 26 Oct 2023 09:46:48 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Javier Carrasco <javier.carrasco@wolfvision.net>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Bastian Hecht <hechtb@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 2/4] dt-bindings: touchscreen: add overlay-touchscreen
 and overlay-buttons properties
Message-ID: <ZTp72LUXxr+Z9gn8@nixie71>
References: <20230510-feature-ts_virtobj_patch-v5-0-ff6b5c4db693@wolfvision.net>
 <20230510-feature-ts_virtobj_patch-v5-2-ff6b5c4db693@wolfvision.net>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230510-feature-ts_virtobj_patch-v5-2-ff6b5c4db693@wolfvision.net>
X-ClientProxiedBy: SN7PR04CA0087.namprd04.prod.outlook.com
 (2603:10b6:806:121::32) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|DM3PR08MB9498:EE_
X-MS-Office365-Filtering-Correlation-Id: 34036bef-72dc-4517-5e8b-08dbd6326753
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HV85cykgHpyjeIi0q5YF7dvSUyFtPFORRjqQ8HxWecnClRPpkTUagTlw4dD5IbEjFPPFCeizcsAI+/tXdqTI800UO5KPyOzblwGHgZPnlrKK+th2qS+JdP7XW7iSwdn5wSiclxcU+CVKFBqNAhFot9c/trg3y3ZXH4TAoRmUueL/PNwGqUS1tnfI6hPcRm9C4pFWedU+beG7Yc6x24LpFDx6DaFjvjj9n1UAlaA4aCTrBtiLsoILHBbotJVPq5r90l5D7BF/cub4t4ajvb5iS7tLWTkQwbekjlARZmSTRGzKbPTVxlsJiby8RXh7uJ8184pD92dylb85JrF7dRT96EB9c+U1ETfvIRd+l4AY0iyW8EQUpvWUoSkNFzERfycAyyKig6nc/HEa1+XyFLJE4pvN4Q4156q9vQJkoN0BQDvqiy8QbljKFL5+YqYFreO31LZ7tjv7nt/ORmmQxRVYrp4G+iVEqUqx5SHEFlmdPKBrWa03XleVORJlYNDd/dEu2JW2QPc7JxTlsiQ+uDvZidXc4fbASNt4SLxFZvhbguuD5MfITG0Q73BNbf+uD5dx06cHYqbe7lkTKK1rAL9hGn8In7W8nnEajiWVHjwb4Qo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(366004)(39830400003)(346002)(396003)(376002)(84040400005)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(66899024)(6666004)(478600001)(6506007)(66476007)(54906003)(66946007)(9686003)(6512007)(86362001)(6486002)(33716001)(41300700001)(26005)(38100700002)(8676002)(8936002)(83380400001)(66556008)(4326008)(7416002)(5660300002)(316002)(6916009)(2906002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXcvWFl5TkVVd2dwT3pWUDUyQTZqUmpNWDJkRGliNWlnTUpCLzVLZ252OElk?=
 =?utf-8?B?NW5TZXVhVjkrbVdBbWZmMkZaOHFCR1RhMUY1aytRcGl2SHRmZDFGTkxMQjVR?=
 =?utf-8?B?eitKcGFJRk5Xb3M0a2doUnBQcENEU2ZHRUsvaTlCZGpCVHBqaTNQK2xpWDBJ?=
 =?utf-8?B?b0d3dEkwVHRiR3p0S2hoNWRsdlBXakNDMHRVZzVFWS9FQlEzbTF5UC9SaXRS?=
 =?utf-8?B?M05raklpNlJWTU85MDl6SmM0NVdqbXQ2aVRMQWErZXJwYm9uaU1iVzh5Skdi?=
 =?utf-8?B?L3RJUlZZbTJCWnNuS291bGVSU3kxdWJzYm8rbHZNSjBTLzNuOEdNM0ppQUd4?=
 =?utf-8?B?ejFGZ2Z4dmluRWVpUk9kTjlnMS9uUFo5bGZiOUwxM3hTMlhJSk1pOSt4RVRr?=
 =?utf-8?B?QUduOWFnalJ5aWVQYi9XR3lkN2lPQ2Rsa3RQVDRXb1pvUEpHN3FXTDJXQUVD?=
 =?utf-8?B?NXFHbW1EbGI3NzJ5VHM2MmVvWVhGRzVTblNCNUtUU1lJdTNURmt0Rm1lUHRH?=
 =?utf-8?B?aHA4ZFZhVXdnUlZoMnkvSlNlckxHc09LQWNRTHJQd2lJNzFOYjcxRDQvTEVP?=
 =?utf-8?B?YTA1R1U5Z1VyYlVIZzJhaHVUTVA0NFM3Y3pwNll2TGVWc080a3kwNkFDU0Q5?=
 =?utf-8?B?eDIveWY4V3ljeE5QNHNZQXB3ajdDQXRYUzZjVEFlbU9ka1pMajRDNlZhb1du?=
 =?utf-8?B?c1VGWmxiTDhLaXRYYU8wUzZSVXg2R00xSTNUcy9YZEs0bk5wUnpBSGYyd3hK?=
 =?utf-8?B?YnFzSFBnMHh5Y2R5enp1MlVxTW1aV3JLNkk1SU1OL0hsTUk3cHlFeVFXNm4v?=
 =?utf-8?B?K3Y5YWJMK0ZDdEdtY1RwdmNJVjdyTkNHT3NpZDhvL1RqNDFiWlZORC9XTlpP?=
 =?utf-8?B?azRyRkFzWUFYZVZ3TzFVT2tpUFZoUWFuZ1QwZVpyNzZReFpQT01Ud1lHbkFN?=
 =?utf-8?B?eGNvQVZ4eU4rTnEzYVZnSHh3VXZGV1haRHNjWDQxNzNKVVhTLzRlNXlMLzQw?=
 =?utf-8?B?STBvbE1SMTcxb2taeHhjakRQcE85Qm9tMW0wQjRZYlNVV3BUdUFYdi83dVVB?=
 =?utf-8?B?TWNZSy8yL3Y3TURrbHlNOGVsT21RN3YvS2EyQTVhaml4cnFjYjRGaXgzeGRy?=
 =?utf-8?B?bkJuRHN1dGtLVHVQOHF6UjRXRm5iWkFsSThrZEZIdjl0dlZGRnhiek9ncFht?=
 =?utf-8?B?dk9NK1lBZEFRc0EvZS9ySXp2a1RhdXNZVGxMRHpDTVJOU2VGTi9FeHQ1SG9h?=
 =?utf-8?B?SWFuNk1ZVXhBZEtlNGg3NW5odXVpb2RWeG1ZNFFzcThOZVc0VEI5cEpGa1VP?=
 =?utf-8?B?Q2lUbFJNWGM4NUN2ZnF2d3NNaDRjQis1MEdTU1ZJazhOY0pZRENMZDNRR2NT?=
 =?utf-8?B?bmI3bXc0eHRjT3JCcVo5dklOVE5MSEtSRWhMbEwxczZWb0ZxdXkrSHArN2xG?=
 =?utf-8?B?bjJpbTVNaXhVc05ZTGZkQSs3MjR1V1BIMVArOFBrZS9SUGVZL253dEQ3aWps?=
 =?utf-8?B?NGIwYmx3dGhkR1Q5TERvVnpxZWJTa1FTN2FHcFFRTkhmWTVxMEh6MDgwZXFD?=
 =?utf-8?B?cWZwVzhnbG9FYXhUSHh4cXlWUjA3RzJEREtmNGhuZGJVZU5UZytzN0w4S0dK?=
 =?utf-8?B?bjd5RDlES25WMEdnaEJXVy92QWNaZTZFYzJXRS9STXhkb0ZiN2N3WUZETHYy?=
 =?utf-8?B?LzVuN3IwMTlvN1Z2ZEdXeDJzclUrbHNFTVN6QStTTzFSUkQzcFp5QnVLYkdz?=
 =?utf-8?B?L3VTYjA0dDRycGVwTlVPbHBKUWpNTGRtalBYMXhqbWVLZW1HMlJpREFlbHIz?=
 =?utf-8?B?YU5DMzU2aDR2cGkxZ2FRbS9TMkpKTnMwQ256OENyRUlNMzRaU3pjUy96Uy85?=
 =?utf-8?B?bmZOdlU3WjhiZlNRbFJqbnN3S3pZNk1MR3grRXM2ZWdUVGl0ZkV0WFljYS9U?=
 =?utf-8?B?RWdSRHgxS09DV1RrWU04a3ZtZnkvSjc0MWlKcnAwN3dwbnJrVGRjNXdRSVUx?=
 =?utf-8?B?aEpZQXBnTlFNQWphNVcvSC9tZTBCditQQ0pmWWlyZVAyWDdqSzVLc3VFa3l0?=
 =?utf-8?B?VHBHUVl4bmU5NXlLM3p4YU5ZVXVjdjY4MzRKMjhMVHZRVDduZ25NcmZkRU1o?=
 =?utf-8?Q?Ao1UVyHoiuaRLh27o9zYpcycr?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34036bef-72dc-4517-5e8b-08dbd6326753
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 14:46:57.5587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hZU12LohNdG1XwcSu/VV6OnCKgLmda6O/on2SytoENUa38EsasO02LU2VnzjMyaGT+J9Zet1UfeGdcgSn5USsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR08MB9498
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier,

Thank you for continuing to drive this high-quality work.

On Tue, Oct 17, 2023 at 01:00:08PM +0200, Javier Carrasco wrote:
> The overlay-touchscreen object defines an area within the touchscreen
> where touch events are reported and their coordinates get converted to
> the overlay origin. This object avoids getting events from areas that
> are physically hidden by overlay frames.
> 
> For touchscreens where overlay buttons on the touchscreen surface are
> provided, the overlay-buttons object contains a node for every button
> and the key event that should be reported when pressed.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
> ---
>  .../bindings/input/touchscreen/touchscreen.yaml    | 143 +++++++++++++++++++++
>  1 file changed, 143 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml
> index 431c13335c40..5c58eb79ee9a 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml
> +++ b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml
> @@ -87,6 +87,129 @@ properties:
>    touchscreen-y-plate-ohms:
>      description: Resistance of the Y-plate in Ohms
>  
> +  overlay-touchscreen:
> +    description: Clipped touchscreen area
> +
> +      This object can be used to describe a frame that restricts the area
> +      within touch events are reported, ignoring the events that occur outside
> +      this area. This is of special interest if the touchscreen is shipped
> +      with a physical overlay on top of it with a frame that hides some part
> +      of the original touchscreen area.
> +
> +      The x-origin and y-origin properties of this object define the offset of
> +      a new origin from where the touchscreen events are referenced.
> +      This offset is applied to the events accordingly. The x-size and y-size
> +      properties define the size of the overlay-touchscreen (effective area).
> +
> +      The following example shows the new touchscreen area and the new origin
> +      (0',0') for the touch events generated by the device.
> +
> +                   Touchscreen (full area)
> +         ┌────────────────────────────────────────┐
> +         │    ┌───────────────────────────────┐   │
> +         │    │                               │   │
> +         │    ├ y-size                        │   │
> +         │    │                               │   │
> +         │    │      overlay-touchscreen      │   │
> +         │    │                               │   │
> +         │    │                               │   │
> +         │    │            x-size             │   │
> +         │   ┌└──────────────┴────────────────┘   │
> +         │(0',0')                                 │
> +        ┌└────────────────────────────────────────┘
> +      (0,0)
> +
> +     where (0',0') = (0+x-origin,0+y-origin)
> +
> +    type: object
> +    $ref: '#/$defs/overlay-node'
> +    unevaluatedProperties: false
> +
> +    required:
> +      - x-origin
> +      - y-origin
> +      - x-size
> +      - y-size
> +
> +  overlay-buttons:
> +    description: list of nodes defining the buttons on the touchscreen
> +
> +      This object can be used to describe buttons on the touchscreen area,
> +      reporting the touch events on their surface as key events instead of
> +      the original touch events.
> +
> +      This is of special interest if the touchscreen is shipped with a
> +      physical overlay on top of it where a number of buttons with some
> +      predefined functionality are printed. In that case a specific behavior
> +      is expected from those buttons instead of raw touch events.
> +
> +      The overlay-buttons properties define a per-button area as well as an
> +      origin relative to the real touchscreen origin. Touch events within the
> +      button area are reported as the key event defined in the linux,code
> +      property. Given that the key events do not provide coordinates, the
> +      button origin is only used to place the button area on the touchscreen
> +      surface. Any event outside the overlay-buttons object is reported as a
> +      touch event with no coordinate transformation.
> +
> +      The following example shows a touchscreen with a single button on it
> +
> +              Touchscreen (full area)
> +        ┌───────────────────────────────────┐
> +        │                                   │
> +        │                                   │
> +        │   ┌─────────┐                     │
> +        │   │button 0 │                     │
> +        │   │KEY_POWER│                     │
> +        │   └─────────┘                     │
> +        │                                   │
> +        │                                   │
> +       ┌└───────────────────────────────────┘
> +     (0,0)
> +
> +      The overlay-buttons object can  be combined with the overlay-touchscreen
> +      object as shown in the following example. In that case only the events
> +      within the overlay-touchscreen object are reported as touch events.
> +
> +                  Touchscreen (full area)
> +        ┌─────────┬──────────────────────────────┐
> +        │         │                              │
> +        │         │    ┌───────────────────────┐ │
> +        │ button 0│    │                       │ │
> +        │KEY_POWER│    │                       │ │
> +        │         │    │                       │ │
> +        ├─────────┤    │  overlay-touchscreen  │ │
> +        │         │    │                       │ │
> +        │         │    │                       │ │
> +        │ button 1│    │                       │ │
> +        │ KEY_INFO│   ┌└───────────────────────┘ │
> +        │         │(0',0')                       │
> +       ┌└─────────┴──────────────────────────────┘
> +     (0,0)
> +
> +    type: object

I am still confused why the buttons need to live under an 'overlay-buttons'
parent node, which seems like an imaginary boundary. In my view, the touch
surface comprises the following types of rectangular areas:

1. A touchscreen, wherein granular coordinates and pressure are reported.
2. A momentary button, wherein pressure is quantized into a binary value
   (press or release), and coordinates are ignored.

Any contact that falls outside of (1) and (2) is presumed to be part of a
border or matting, and is hence ignored.

Areas (1) and (2) exist in the same "plane", so why can they not reside
under the same parent node? The following seems much more representative
of the actual hardware we intend to describe in the device tree:

	touchscreen {
		compatible = "...";
		reg = <...>;

		/* raw coordinates reported here */
		touch-area-1 {
			x-origin = <...>;
			y-origin = <...>;
			x-size = <...>;
			y-size = <...>;
		};

		/* a button */
		touch-area-2a {
			x-origin = <...>;
			y-origin = <...>;
			x-size = <...>;
			y-size = <...>;
			linux,code = <KEY_POWER>;
		};

		/* another button */
		touch-area-2b {
			x-origin = <...>;
			y-origin = <...>;
			x-size = <...>;
			y-size = <...>;
			linux,code = <KEY_INFO>;
		};
	};

With this method, the driver merely stores a list head. The parsing code
then walks the client device node; for each touch* child encountered, it
allocates memory for a structure of five members, and adds it to the list.

The event handling code then simply iterates through the list and checks
if the coordinates reported by the hardware fall within each rectangle. If
so, and the keycode in the list element is equal to KEY_RESERVED (zero),
we assume the rectangle is of type (1); the coordinates are passed to
touchscreen_report_pos() and the pressure is reported as well.

If the keycode is not equal to KEY_RESERVED (e.g. KEY_POWER), we assume
the rectangle is of type (2); input_report_key() is called instead and
the coordinates are ignored altogether.

Instead, the existing implementation has two separate structures, one of
which inherits the other. Its corresponding properties are then parsed in
a separate function to account for the fact that the two structures exist
at different layers in the heirarchy.

My argument is that all nodes can be parsed in the same way, without having
to understand whether they represent case (1) or (2). The existing method
also has to count the nodes; this would not be necessary with a linked list.

Can you help me understand why the buttons must be "wrapped" in their own
node? As I mention in v2, this isn't a deal breaker necessarily, but I'd
like to understand the reasoning behind what I interpret as additional
complexity, and a degree of separation from a natural description of the
touch surface.

The only reason I can think to insert the 'overlay-buttons' parent is in
case we want to specify a property within this node that applies to all
buttons, but this does not exist in the current implementation, nor do I
see a compelling reason to do so in the future.

> +
> +    patternProperties:
> +      '^button-':
> +        type: object
> +        description:
> +          Each button (key) is represented as a sub-node.
> +        $ref: '#/$defs/overlay-node'
> +        unevaluatedProperties: false
> +
> +        properties:
> +          label:
> +            $ref: /schemas/types.yaml#/definitions/string
> +            description: descriptive name of the button
> +
> +          linux,code: true
> +
> +        required:
> +          - linux,code
> +          - x-origin
> +          - y-origin
> +          - x-size
> +          - y-size
> +
>  dependencies:
>    touchscreen-size-x: [ touchscreen-size-y ]
>    touchscreen-size-y: [ touchscreen-size-x ]
> @@ -94,3 +217,23 @@ dependencies:
>    touchscreen-y-mm: [ touchscreen-x-mm ]
>  
>  additionalProperties: true
> +
> +$defs:
> +  overlay-node:
> +    type: object
> +    properties:
> +      x-origin:
> +        description: horizontal origin of the node area
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +
> +      y-origin:
> +        description: vertical origin of the node area
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +
> +      x-size:
> +        description: horizontal resolution of the node area
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +
> +      y-size:
> +        description: vertical resolution of the node area
> +        $ref: /schemas/types.yaml#/definitions/uint32
> 
> -- 
> 2.39.2
> 

Kind regards,
Jeff LaBundy
