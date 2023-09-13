Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD01979E88E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 15:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239132AbjIMNED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 09:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbjIMNEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 09:04:02 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D697B19B4;
        Wed, 13 Sep 2023 06:03:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=epSJQdd0ahZnr1eJr0UCyJeEAZULLMQZK5aCHtlima7ING01MoBHbkQ24yXyZP8kKHUIuxU2FyBPZq7sQenOB3HgLOYu+SesuWtSRzta8PWszFOKbMsKKRuprePq9Pd2hy4GyUitwx436LvTN1C5sI4KEuhfuBxCt/CJZgGZP/v9R2gAjah5RlInJwWQxJ75vPMowSImTY0724sLFE7f56YJsaTfgzp8eiyicAfgEfYR2NaNMz3tfu2hsgdNzjhmAWg4KZNA+4WA6mAB6LqQbdf/SleVjLg8AKndSJmN5J28mg5+lRBD3UBMIFtKxItRdNi6iKbilfREwqJNM/KGjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iVTNhPVYP5bJJTXxZUMN4+VolZyZvHb+sOQ3F9b90VY=;
 b=g/T9h8MV8TcFKhlvV5pkHhhNOgg+wRWwdZqImMJ8aWbUcPZuKltAL7LieLNWCPCB9Zp9aoOlxO71yn6h6tqJqwP70QFENMFrjeMDD6qd4a+a2NDd6Q0H2ZPujsfBrC6rE6Z9Lf6xOJmu6V52db0CXF4mFshBvcMy8jS1hW1kWm0diPzROZRuQkuH6yI5NGgJP6iJYqeSVzdrFJrdTotgDmoqkzujG0EFsUKjWWivWrBhGXiqOlBk9ybYLQmZeFwWshpkeq7BDNZHTjQjEEnAb7p6v9MgFRHen4IugkyO8sTTsdwoz5DLqoafBjES/Dn4eq5T9w9PjU91Yix+i6RNbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iVTNhPVYP5bJJTXxZUMN4+VolZyZvHb+sOQ3F9b90VY=;
 b=Gbq+SPbwLjBJ0jFob8o+xde+6AZXQw6B97M3kue51isECSkrtgwqmQwqAjThwNcyhaiZS91uXhvTLyA1LBuyXTip8OiBNv8Bs/Hn2RTmRIsv72gVXmja0cCclmu9Ci6EX9pEM20jFCTWmCTJBQN3oUa3mlfAkbUgHsoJtspOo1o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5176.namprd12.prod.outlook.com (2603:10b6:208:311::19)
 by IA0PR12MB8895.namprd12.prod.outlook.com (2603:10b6:208:491::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Wed, 13 Sep
 2023 13:03:50 +0000
Received: from BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::5564:8c7:6c3a:867d]) by BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::5564:8c7:6c3a:867d%6]) with mapi id 15.20.6792.019; Wed, 13 Sep 2023
 13:03:50 +0000
Message-ID: <9e38c20f-fa2a-4b35-948c-798213655f08@amd.com>
Date:   Wed, 13 Sep 2023 18:33:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: supply: core: Use blocking_notifier_call_chain to
 avoid RCU complaint
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>, sre@kernel.org
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230913033233.602986-1-kai.heng.feng@canonical.com>
 <b65ba85d-a129-47a0-8019-df8af98f9451@amd.com>
Content-Language: en-US
From:   Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
In-Reply-To: <b65ba85d-a129-47a0-8019-df8af98f9451@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0230.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::15) To BL1PR12MB5176.namprd12.prod.outlook.com
 (2603:10b6:208:311::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5176:EE_|IA0PR12MB8895:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c754db7-fe98-4d91-c067-08dbb459df70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I93d0IjavTRBT0BsdUKsWTAf0JSMDn4tvV5JviYSRd9hkjwkiEIbgxzaKsebQivVtYvvQql4KMlBzB45D5yoJzNheqThKNgDF5NC86o3YkDcRRFQCrlamgAE3a9Xy+flLkW71R8SCgwmacfrf4r/qYQZuKZgy9MLfCMHF7Pwi8hz0Dv2/PkLNJ2VL/gQOdBupw8+Xwjz+oeb+E/VMjkw0ZHKvhCFTukoMFeXPpucIlWq9+PeYNzEEl/xugovSAqCGJzo4OtknXVkWUBiCFGawuIhx5RruWyigeDuciNClK7vU+e2gi9lHHr0TCQ+ZluQtbY/8qMbAbE607aV7TOc9YPbZ2LjHzFqMhFTZFbrzrguvkIDqVmEvlyOVQaout3SMERNfHJeAiWMlqJOJvrG+Xd+taKjOcG8OnUqeKdJywcIQGO7KZGfJMYZo1lnrKnhTvUi0Gm9JbJl8xrsUlneAuNRU4L9U+QnQSCmzzhsIpsmf9yw3w+JGTSBR3Jlltx7anvjYiHGlNDvddKgiZo68GLJbeOMql1KUQhzhdxgRPEGpkX5VAg0Pxtqy+SXnd0Q9E68S23qz1B4qcpAoC2rc5ySs+LmFREyuFX6WLZQ2Y23FfpJakaO7XqbzE2dNnhjpE/Qa4FmriZ1iFVDm1CoDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(396003)(39860400002)(136003)(451199024)(1800799009)(186009)(8936002)(2906002)(5660300002)(8676002)(4326008)(41300700001)(31686004)(66556008)(66476007)(26005)(66946007)(110136005)(316002)(966005)(478600001)(53546011)(45080400002)(6486002)(6506007)(6666004)(6512007)(2616005)(36756003)(83380400001)(38100700002)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmlpczBNS3pGZlVUdWYxbUlyak5CSXo1QWZoeWRXSHNLQkt3K3l3Z2NvUGN3?=
 =?utf-8?B?alNSVXNlVnBBckIzR1JJK0xJY1NGd0VUaDREZzlLeko2aHBZNjE3UDBDR0hC?=
 =?utf-8?B?Qm83L1NTT2RtTEk3aSt6ckQ5ZDVGRUVlL0h1TlRTbWNVRTdONE9FVjZNM0xO?=
 =?utf-8?B?SGhWcURGTFFXZWVCUm4vekRjckhEbnFIMEVEdlFKaG9hSXFjMWpHZXB0aEp1?=
 =?utf-8?B?Rkltd3ZMMmw5QnpjVlRQUDcrLzhlM1AxS292WVhicm5HMXBOTmlIQ3h4M2lS?=
 =?utf-8?B?R015Nzk4MXl2UGM5TXQyLzFpNWxRL3BZSDBJQkIybzV6LzMwbTFGTkp5WWZl?=
 =?utf-8?B?N1VHd3dUWGJGQ29SRHBwKzRHdElJRlB6V3huZXZVRXNqSGNKOEtrN2IyaFI5?=
 =?utf-8?B?OXpTdGVkRUN0eXRZU0pTakFlZ3hpQkNlWnFSR1pTQnVmcWlINm5uRDlCV2Ix?=
 =?utf-8?B?WERwd3dibUN3djY5RUl3emZ4YWVyMlgzVG84Y1hqV0ZCazBSdnhTUFcyZ0pO?=
 =?utf-8?B?MFBOZldTN1Z1VUsrWlozVkZGaFZWdE1MN04rd0VnbWthbHNOY0FsSjVLcm91?=
 =?utf-8?B?SkFNbnlOTGprZXVKL1VFY1NMUFNTOGxuWHIrV3ZRYWhkM1FUTHF4TnpSblly?=
 =?utf-8?B?QTg0NHMzNksydnNqRWVocDNCWWJLSXVnSEhjblRTOTdzRDdLUTV2Mm1EbGdQ?=
 =?utf-8?B?aW5NQXNBeHA2RVoyOWEzUFIyTUIxZEFYUm9Ub0ZDaG5ESkFldHAvT0JRN2dT?=
 =?utf-8?B?aVlWRGpvUSs5ekowbEFpWTJ5OWMrb2I2aGsvbERmc1Y0YmR6dHZQQXhUbEc4?=
 =?utf-8?B?QkhaWGM0RW1hNHFOTitMVW9oZnNrMXM2SGdsYVdnRzVEczFmay80bGdZd3pF?=
 =?utf-8?B?dE02QnVZSE5rQ2hiQWUxSzdLR1lnaGtiWmZmTS93STdMMW1ta1BNd1NsTU05?=
 =?utf-8?B?UTlzdE1xaDl5dXpVNzQ5TXNPSkZ3eDhaY09ZRlJpOEhyR1pIM0JGaFZ0NzY1?=
 =?utf-8?B?blUvakpCdE9YZHh3dlRLWHdlaHlHb01UdHI2Y3ZDL0NSaXVlQWpUUCs4T0hj?=
 =?utf-8?B?MnV4bWlNamxBMmJobm5rMGY1QnJNL21vVHZUNzlXVmY5Mk5YUHdUd3A2dU5q?=
 =?utf-8?B?VStNQVY2QlRqU1dzNVJ2b1Vma0xiWXRqdjZteFovNGFnM2ZxNjVwa1gxbEUz?=
 =?utf-8?B?MnJqelVYaXlzWFJyYU5YbnRucG5rYmUwM0ZBVUp2Tk5OSVp0TUs4NTJBMERR?=
 =?utf-8?B?bHNDOURmcGxsblFSeTdKOHplbTZWSEpWTUdER2ptdU03T0xlNnFjK2dyaS9X?=
 =?utf-8?B?bS9rdC9zbk54MWRYamFDMDhEcHBDV3pQZDJWTnZvUnNzekYyeUZoT0RZZlpJ?=
 =?utf-8?B?aGRJRmxXOXkxQ2hrYk1mOURWTDE4NEpXSnNQZk5DeGdJRFovS1l3eUJsQjZW?=
 =?utf-8?B?WGZOekdvMGNIMkZySG9UbUhRUndUb0N5U0YwVWNZTEU5ZmdpcjBqZmpBRXlT?=
 =?utf-8?B?dVdQdng1N29QY2pZUGVIOFI0K205cmUzMllma0hzK0hGWUJwaXN2Sy9zOW9j?=
 =?utf-8?B?QUlJSkZTZmlpc1ZrKzkxcjducENIYXFSZWhUbStrNWl3aGgwai9vblBMVlFI?=
 =?utf-8?B?RExneHdWUDlWdXEvMFNaaWNhUHlPZ2F0US9pWXZWRUNwUnhpeGFHTG9EOEZR?=
 =?utf-8?B?dWFBUjNGQU5sTm5pU3dwWVpWWnk4c2lYYWt0NFFPN3pNWVIvOU5NcXJ5OG5M?=
 =?utf-8?B?R24rK1dIS05FaHpWWHZ4UE9STWVRamxnSW44aFE4M0l3YjNBS000TXAzV09u?=
 =?utf-8?B?TFQ0NjdscU9raDZGcVFTK3o0c1dEN3RiVVBMd2h1QThsRWd2RXRhdWhnNVN2?=
 =?utf-8?B?Y0s5OUhOdWN4L09WZGRySGVMSzJvSFhSU3RidEtTRW9TUjRSb2RYMFpUZWFx?=
 =?utf-8?B?UmM4R3FnWkFNU2xhU0FCTUlObVpXU0tseXNnbTJUbzVWUXRUNWNlQjdaVUdB?=
 =?utf-8?B?VDFiNmxpSDZBL1ZkdmtKOFBnRVErTUVQRzc2b2dMK0FNaS9hanVUMVV3WWQw?=
 =?utf-8?B?UzRhQUpHSENBRGczSGNGWFlLNityNWVlc0R6Tlh1WUZvMUdSWHBQaGhJWmFn?=
 =?utf-8?Q?BLi/jkGeOBXEN05dRi2GEs2kg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c754db7-fe98-4d91-c067-08dbb459df70
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 13:03:50.0375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /d4ExLtrnJEsTo9xdduyjPIDps+Nql9lbaJ8XdlvXA6TYiUzIuqhl8H5SqkN8OsRLG/68v5Yh6M0b2leW2Gwjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8895
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kai-Heng Feng,

On 9/13/2023 9:45 AM, Mario Limonciello wrote:
> On 9/12/2023 22:32, Kai-Heng Feng wrote:
>> AMD PMF driver can cause the following warning:
>> [  196.159546] ------------[ cut here ]------------
>> [  196.159556] Voluntary context switch within RCU read-side critical
>> section!
>> [  196.159571] WARNING: CPU: 0 PID: 9 at kernel/rcu/tree_plugin.h:320
>> rcu_note_context_switch+0x43d/0x560
>> [  196.159604] Modules linked in: nvme_fabrics ccm rfcomm
>> snd_hda_scodec_cs35l41_spi cmac algif_hash algif_skcipher af_alg bnep
>> joydev btusb btrtl uvcvideo btintel btbcm videobuf2_vmalloc
>> intel_rapl_msr btmtk videobuf2_memops uvc videobuf2_v4l2
>> intel_rapl_common binfmt_misc hid_sensor_als snd_sof_amd_vangogh
>> hid_sensor_trigger bluetooth industrialio_triggered_buffer videodev
>> snd_sof_amd_rembrandt hid_sensor_iio_common amdgpu ecdh_generic
>> kfifo_buf videobuf2_common hp_wmi kvm_amd sparse_keymap
>> snd_sof_amd_renoir wmi_bmof industrialio ecc mc nls_iso8859_1 kvm
>> snd_sof_amd_acp irqbypass snd_sof_xtensa_dsp crct10dif_pclmul
>> crc32_pclmul mt7921e snd_sof_pci snd_ctl_led polyval_clmulni
>> mt7921_common polyval_generic snd_sof ghash_clmulni_intel mt792x_lib
>> mt76_connac_lib sha512_ssse3 snd_sof_utils aesni_intel
>> snd_hda_codec_realtek crypto_simd mt76 snd_hda_codec_generic cryptd
>> snd_soc_core snd_hda_codec_hdmi rapl ledtrig_audio input_leds
>> snd_compress i2c_algo_bit drm_ttm_helper mac80211 snd_pci_ps
>> hid_multitouch ttm drm_exec
>> [  196.159970]  drm_suballoc_helper snd_rpl_pci_acp6x amdxcp
>> drm_buddy snd_hda_intel snd_acp_pci snd_hda_scodec_cs35l41_i2c
>> serio_raw gpu_sched snd_hda_scodec_cs35l41 snd_acp_legacy_common
>> snd_intel_dspcfg snd_hda_cs_dsp_ctls snd_hda_codec libarc4
>> drm_display_helper snd_pci_acp6x cs_dsp snd_hwdep snd_soc_cs35l41_lib
>> video k10temp snd_pci_acp5x thunderbolt snd_hda_core drm_kms_helper
>> cfg80211 snd_seq snd_rn_pci_acp3x snd_pcm snd_acp_config cec
>> snd_soc_acpi snd_seq_device rc_core ccp snd_pci_acp3x snd_timer snd
>> soundcore wmi amd_pmf platform_profile amd_pmc mac_hid
>> serial_multi_instantiate wireless_hotkey hid_sensor_hub sch_fq_codel
>> msr parport_pc ppdev lp parport efi_pstore ip_tables x_tables autofs4
>> btrfs blake2b_generic raid10 raid456 async_raid6_recov async_memcpy
>> async_pq async_xor async_tx libcrc32c xor raid6_pq raid1 raid0
>> multipath linear dm_mirror dm_region_hash dm_log cdc_ether usbnet
>> r8152 mii hid_generic nvme i2c_hid_acpi i2c_hid nvme_core i2c_piix4
>> xhci_pci amd_sfh drm xhci_pci_renesas nvme_common hid
>> [  196.160382] CPU: 0 PID: 9 Comm: kworker/0:1 Not tainted 6.6.0-rc1 #4
>> [  196.160397] Hardware name: HP HP EliteBook 845 14 inch G10
>> Notebook PC/8B6E, BIOS V82 Ver. 01.02.00 08/24/2023
>> [  196.160405] Workqueue: events power_supply_changed_work
>> [  196.160426] RIP: 0010:rcu_note_context_switch+0x43d/0x560
>> [  196.160440] Code: 00 48 89 be 40 08 00 00 48 89 86 48 08 00 00 48
>> 89 10 e9 63 fe ff ff 48 c7 c7 10 e7 b0 9e c6 05 e8 d8 20 02 01 e8 13
>> 0f f3 ff <0f> 0b e9 27 fc ff ff a9 ff ff ff 7f 0f 84 cf fc ff ff 65
>> 48 8b 3c
>> [  196.160450] RSP: 0018:ffffc900001878f0 EFLAGS: 00010046
>> [  196.160462] RAX: 0000000000000000 RBX: ffff88885e834040 RCX:
>> 0000000000000000
>> [  196.160470] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
>> 0000000000000000
>> [  196.160476] RBP: ffffc90000187910 R08: 0000000000000000 R09:
>> 0000000000000000
>> [  196.160482] R10: 0000000000000000 R11: 0000000000000000 R12:
>> 0000000000000000
>> [  196.160488] R13: 0000000000000000 R14: ffff888100990000 R15:
>> ffff888100990000
>> [  196.160495] FS:  0000000000000000(0000) GS:ffff88885e800000(0000)
>> knlGS:0000000000000000
>> [  196.160504] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [  196.160512] CR2: 000055cb053c8246 CR3: 000000013443a000 CR4:
>> 0000000000750ef0
>> [  196.160520] PKRU: 55555554
>> [  196.160526] Call Trace:
>> [  196.160532]  <TASK>
>> [  196.160548]  ? show_regs+0x72/0x90
>> [  196.160570]  ? rcu_note_context_switch+0x43d/0x560
>> [  196.160580]  ? __warn+0x8d/0x160
>> [  196.160600]  ? rcu_note_context_switch+0x43d/0x560
>> [  196.160613]  ? report_bug+0x1bb/0x1d0
>> [  196.160637]  ? handle_bug+0x46/0x90
>> [  196.160658]  ? exc_invalid_op+0x19/0x80
>> [  196.160675]  ? asm_exc_invalid_op+0x1b/0x20
>> [  196.160709]  ? rcu_note_context_switch+0x43d/0x560
>> [  196.160727]  __schedule+0xb9/0x15f0
>> [  196.160746]  ? srso_alias_return_thunk+0x5/0x7f
>> [  196.160765]  ? srso_alias_return_thunk+0x5/0x7f
>> [  196.160778]  ? acpi_ns_search_one_scope+0xbe/0x270
>> [  196.160806]  schedule+0x68/0x110
>> [  196.160820]  schedule_timeout+0x151/0x160
>> [  196.160829]  ? srso_alias_return_thunk+0x5/0x7f
>> [  196.160842]  ? srso_alias_return_thunk+0x5/0x7f
>> [  196.160855]  ? acpi_ns_lookup+0x3c5/0xa90
>> [  196.160878]  __down_common+0xff/0x220
>> [  196.160905]  __down_timeout+0x16/0x30
>> [  196.160920]  down_timeout+0x64/0x70
>> [  196.160938]  acpi_os_wait_semaphore+0x85/0x200
>> [  196.160959]  acpi_ut_acquire_mutex+0x9e/0x280
>> [  196.160979]  acpi_ex_enter_interpreter+0x2d/0xb0
>> [  196.160992]  acpi_ns_evaluate+0x2f0/0x5f0
>> [  196.161005]  acpi_evaluate_object+0x172/0x490
>> [  196.161018]  ? acpi_os_signal_semaphore+0x8a/0xd0
>> [  196.161038]  acpi_evaluate_integer+0x52/0xe0
>> [  196.161055]  ? kfree+0x79/0x120
>> [  196.161071]  ? srso_alias_return_thunk+0x5/0x7f
>> [  196.161089]  acpi_ac_get_state.part.0+0x27/0x80
>> [  196.161110]  get_ac_property+0x5c/0x70
>> [  196.161127]  ? __pfx___power_supply_is_system_supplied+0x10/0x10
>> [  196.161146]  __power_supply_is_system_supplied+0x44/0xb0
>> [  196.161166]  class_for_each_device+0x124/0x160
>> [  196.161184]  ? acpi_ac_get_state.part.0+0x27/0x80
>> [  196.161203]  ? srso_alias_return_thunk+0x5/0x7f
>> [  196.161223]  power_supply_is_system_supplied+0x3c/0x70
>> [  196.161243]  amd_pmf_get_power_source+0xe/0x20 [amd_pmf]
>> [  196.161276]  amd_pmf_power_slider_update_event+0x49/0x90 [amd_pmf]
>> [  196.161310]  amd_pmf_pwr_src_notify_call+0xe7/0x100 [amd_pmf]
>> [  196.161340]  notifier_call_chain+0x5f/0xe0
>> [  196.161362]  atomic_notifier_call_chain+0x33/0x60
>> [  196.161378]  power_supply_changed_work+0x84/0x110
>> [  196.161394]  process_one_work+0x178/0x360
>> [  196.161412]  ? __pfx_worker_thread+0x10/0x10
>> [  196.161424]  worker_thread+0x307/0x430
>> [  196.161440]  ? __pfx_worker_thread+0x10/0x10
>> [  196.161451]  kthread+0xf4/0x130
>> [  196.161467]  ? __pfx_kthread+0x10/0x10
>> [  196.161486]  ret_from_fork+0x43/0x70
>> [  196.161502]  ? __pfx_kthread+0x10/0x10
>> [  196.161518]  ret_from_fork_asm+0x1b/0x30
>> [  196.161558]  </TASK>
>> [  196.161562] ---[ end trace 0000000000000000 ]---
>>
>> Since there's no guarantee that all the callbacks can work in atomic
>> context, switch to use blocking_notifier_call_chain to relax the
>> constraint.
>>
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>
> I believe this is actually the same bug that was reported in the past
> but it was masked by other changes.
> Considering that I think these tags apply to this situation:
>
> Fixes: 4c71ae414474 ("platform/x86/amd/pmf: Add support SPS PMF feature")

Thank you for the fix, but the right fixes tag for this one should be:

Fixes: d36240d26025 ("power_supply: Add power_supply notifier")


with that change in place:

Reviewed-by: Shyam Sundar S K Shyam-sundar.S-k@amd.com


Thanks,

Shyam

> Reported-by: Allen Zhong <allen@atr.me>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217571
>
> The fix looks good to me as well, thanks.
>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
>
>> ---
>>   drivers/power/supply/power_supply_core.c | 8 ++++----
>>   include/linux/power_supply.h             | 2 +-
>>   2 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/power/supply/power_supply_core.c
>> b/drivers/power/supply/power_supply_core.c
>> index 0b69fb7bafd8..416409e2fd6d 100644
>> --- a/drivers/power/supply/power_supply_core.c
>> +++ b/drivers/power/supply/power_supply_core.c
>> @@ -29,7 +29,7 @@
>>   struct class *power_supply_class;
>>   EXPORT_SYMBOL_GPL(power_supply_class);
>>   -ATOMIC_NOTIFIER_HEAD(power_supply_notifier);
>> +BLOCKING_NOTIFIER_HEAD(power_supply_notifier);
>>   EXPORT_SYMBOL_GPL(power_supply_notifier);
>>     static struct device_type power_supply_dev_type;
>> @@ -97,7 +97,7 @@ static void power_supply_changed_work(struct
>> work_struct *work)
>>           class_for_each_device(power_supply_class, NULL, psy,
>>                         __power_supply_changed_work);
>>           power_supply_update_leds(psy);
>> -        atomic_notifier_call_chain(&power_supply_notifier,
>> +        blocking_notifier_call_chain(&power_supply_notifier,
>>                   PSY_EVENT_PROP_CHANGED, psy);
>>           kobject_uevent(&psy->dev.kobj, KOBJ_CHANGE);
>>           spin_lock_irqsave(&psy->changed_lock, flags);
>> @@ -1262,13 +1262,13 @@ static void power_supply_dev_release(struct
>> device *dev)
>>     int power_supply_reg_notifier(struct notifier_block *nb)
>>   {
>> -    return atomic_notifier_chain_register(&power_supply_notifier, nb);
>> +    return blocking_notifier_chain_register(&power_supply_notifier,
>> nb);
>>   }
>>   EXPORT_SYMBOL_GPL(power_supply_reg_notifier);
>>     void power_supply_unreg_notifier(struct notifier_block *nb)
>>   {
>> -    atomic_notifier_chain_unregister(&power_supply_notifier, nb);
>> +    blocking_notifier_chain_unregister(&power_supply_notifier, nb);
>>   }
>>   EXPORT_SYMBOL_GPL(power_supply_unreg_notifier);
>>   diff --git a/include/linux/power_supply.h
>> b/include/linux/power_supply.h
>> index a427f13c757f..85b86768c0b9 100644
>> --- a/include/linux/power_supply.h
>> +++ b/include/linux/power_supply.h
>> @@ -767,7 +767,7 @@ struct power_supply_battery_info {
>>       int bti_resistance_tolerance;
>>   };
>>   -extern struct atomic_notifier_head power_supply_notifier;
>> +extern struct blocking_notifier_head power_supply_notifier;
>>   extern int power_supply_reg_notifier(struct notifier_block *nb);
>>   extern void power_supply_unreg_notifier(struct notifier_block *nb);
>>   #if IS_ENABLED(CONFIG_POWER_SUPPLY)
>
